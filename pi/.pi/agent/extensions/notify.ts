/**
 * Local Pi notification extension.
 *
 * Adapted from @jmcombs/pi-notify at commit
 * e91bd92d0565570c4b001211fb6741a8e3d2d90a.
 * Upstream license: MIT.
 *
 * Sends a native OS notification when Pi finishes a turn and is waiting for
 * user input. Falls back to an in-Pi UI notification if native delivery fails.
 */

import { execFile } from "node:child_process";
import { promisify } from "node:util";
import type { ExtensionAPI, ExtensionContext } from "@mariozechner/pi-coding-agent";

const execFileAsync = promisify(execFile);
const TITLE = "Pi";
const DEFAULT_MESSAGE = "Waiting for your input";

async function sendMacOS(title: string, message: string): Promise<void> {
	const script = `display notification ${JSON.stringify(message)} with title ${JSON.stringify(title)}`;
	await execFileAsync("osascript", ["-e", script]);
}

async function sendLinux(title: string, message: string): Promise<void> {
	await execFileAsync("notify-send", [title, message]);
}

async function sendNotification(title: string, message: string, ctx: ExtensionContext): Promise<void> {
	try {
		if (process.platform === "darwin") {
			await sendMacOS(title, message);
		} else if (process.platform === "linux") {
			await sendLinux(title, message);
		} else {
			ctx.ui.notify(message, "info");
		}
	} catch {
		ctx.ui.notify(message, "info");
	}
}

export default function (pi: ExtensionAPI): void {
	pi.on("agent_end", async (_event, ctx) => {
		await sendNotification(TITLE, DEFAULT_MESSAGE, ctx);
	});

	pi.registerCommand("notify", {
		description: "Send a test OS notification (macOS and Linux only).",
		handler: async (args, ctx) => {
			const message = args.trim() || DEFAULT_MESSAGE;
			await sendNotification(TITLE, message, ctx);
		},
	});
}
