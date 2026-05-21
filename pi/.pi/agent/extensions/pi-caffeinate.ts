/**
 * Local, macOS-only Pi caffeinate extension.
 *
 * Inspired by @narumitw/pi-caffeinate (MIT). Keeps macOS awake while Pi is
 * actively processing a prompt by running `caffeinate -disu`.
 */

import { type ChildProcess, spawn } from "node:child_process";
import process from "node:process";
import type { ExtensionAPI, ExtensionContext } from "@mariozechner/pi-coding-agent";

const STATUS_KEY = "caffeinate";
const COMMAND = "caffeinate";
const ARGS = ["-disu"];

let caffeinateProcess: ChildProcess | undefined;
let startedAt: number | undefined;
let activeTurns = 0;
let lastError: string | undefined;

export default function (pi: ExtensionAPI): void {
	pi.on("session_start", (_event, ctx) => {
		updateStatus(ctx);
	});

	pi.on("agent_start", (_event, ctx) => {
		activeTurns += 1;
		start(ctx);
	});

	pi.on("agent_end", (_event, ctx) => {
		activeTurns = Math.max(0, activeTurns - 1);
		if (activeTurns === 0) stop(ctx, "agent finished");
		updateStatus(ctx);
	});

	pi.on("session_shutdown", (_event, ctx) => {
		activeTurns = 0;
		stop(ctx, "session shutdown", false);
		ctx.ui.setStatus(STATUS_KEY, undefined);
	});

	pi.registerCommand("caffeinate-status", {
		description: "Show whether macOS caffeinate is active for Pi.",
		handler: async (_args, ctx) => {
			ctx.ui.notify(describe(), caffeinateProcess || !lastError ? "info" : "warning");
			updateStatus(ctx);
		},
	});

	pi.registerCommand("caffeinate-stop", {
		description: "Stop Pi's active macOS caffeinate process.",
		handler: async (_args, ctx) => {
			activeTurns = 0;
			stop(ctx, "manual stop");
			updateStatus(ctx);
		},
	});
}

function start(ctx: ExtensionContext): void {
	if (process.platform !== "darwin") {
		lastError = "pi-caffeinate is macOS-only.";
		updateStatus(ctx);
		return;
	}

	if (caffeinateProcess) {
		updateStatus(ctx);
		return;
	}

	try {
		const child = spawn(COMMAND, ARGS, { stdio: "ignore" });
		caffeinateProcess = child;
		startedAt = Date.now();
		lastError = undefined;

		child.once("error", (error) => {
			if (caffeinateProcess === child) {
				caffeinateProcess = undefined;
				startedAt = undefined;
			}
			lastError = `Failed to start caffeinate: ${error.message}`;
			ctx.ui.notify(lastError, "warning");
			updateStatus(ctx);
		});

		child.once("exit", (code, signal) => {
			if (caffeinateProcess !== child) return;
			caffeinateProcess = undefined;
			startedAt = undefined;
			lastError = `caffeinate exited unexpectedly (${formatExit(code, signal)}).`;
			ctx.ui.notify(lastError, "warning");
			updateStatus(ctx);
		});

		updateStatus(ctx);
	} catch (error) {
		caffeinateProcess = undefined;
		startedAt = undefined;
		lastError = error instanceof Error ? error.message : String(error);
		ctx.ui.notify(`Unable to start caffeinate: ${lastError}`, "warning");
		updateStatus(ctx);
	}
}

function stop(ctx: ExtensionContext, reason: string, notify = true): void {
	const child = caffeinateProcess;
	if (!child) return;

	caffeinateProcess = undefined;
	startedAt = undefined;
	child.removeAllListeners("error");
	child.removeAllListeners("exit");
	if (!child.killed) child.kill("SIGTERM");

	if (notify) ctx.ui.notify(`Released caffeinate (${reason}).`, "info");
}

function updateStatus(ctx: ExtensionContext): void {
	ctx.ui.setStatus(STATUS_KEY, caffeinateProcess ? "☕ awake" : undefined);
}

function describe(): string {
	if (caffeinateProcess) {
		const seconds = startedAt ? Math.round((Date.now() - startedAt) / 1000) : 0;
		return `caffeinate is active for ${seconds}s.`;
	}
	if (lastError) return lastError;
	return "caffeinate is idle and will start while Pi is working.";
}

function formatExit(code: number | null, signal: NodeJS.Signals | null): string {
	if (signal) return `signal ${signal}`;
	return `code ${code ?? "unknown"}`;
}
