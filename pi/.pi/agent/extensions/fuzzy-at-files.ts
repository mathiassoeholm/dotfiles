import { CustomEditor, type ExtensionAPI } from "@mariozechner/pi-coding-agent";
import type { AutocompleteItem, AutocompleteProvider, AutocompleteSuggestions } from "@mariozechner/pi-tui";
import { spawnSync } from "node:child_process";
import { constants } from "node:fs";
import { accessSync } from "node:fs";
import { basename, isAbsolute, join, resolve } from "node:path";
import { homedir } from "node:os";

function isExecutable(path: string): boolean {
	try {
		accessSync(path, constants.X_OK);
		return true;
	} catch {
		return false;
	}
}

function unique(values: string[]): string[] {
	return [...new Set(values.filter(Boolean))];
}

function findBinary(names: string[]): string | undefined {
	const searchDirs = unique([
		...(process.env.PATH?.split(":") ?? []),
		join(homedir(), ".pi", "agent", "bin"),
		"/opt/homebrew/bin",
		"/usr/local/bin",
		"/usr/bin",
	]);

	for (const dir of searchDirs) {
		for (const name of names) {
			const candidate = join(dir, name);
			if (isExecutable(candidate)) return candidate;
		}
	}
	return undefined;
}

const fdPath = findBinary(["fd", "fdfind"]);
const fzfPath = findBinary(["fzf"]);
const TOKEN_DELIMITERS = new Set([" ", "\t", '"', "'"]);

function extractAtPrefix(text: string): string | null {
	let lastDelimiter = -1;
	for (let i = text.length - 1; i >= 0; i--) {
		if (TOKEN_DELIMITERS.has(text[i]!)) {
			lastDelimiter = i;
			break;
		}
	}

	const token = text.slice(lastDelimiter + 1);
	return token.startsWith("@") ? token : null;
}

function resolveQueryPath(rawQuery: string, basePath: string): { searchDir: string; fileQuery: string; dirPrefix: string } {
	const lastSlash = rawQuery.lastIndexOf("/");
	if (lastSlash === -1) {
		return { searchDir: basePath, fileQuery: rawQuery, dirPrefix: "" };
	}

	const dirPrefix = rawQuery.slice(0, lastSlash + 1);
	const fileQuery = rawQuery.slice(lastSlash + 1);
	let searchDir: string;

	if (dirPrefix.startsWith("~/")) {
		searchDir = join(homedir(), dirPrefix.slice(2));
	} else if (isAbsolute(dirPrefix)) {
		searchDir = dirPrefix;
	} else {
		searchDir = resolve(basePath, dirPrefix);
	}

	return { searchDir, fileQuery, dirPrefix };
}

function listMatches(searchDir: string, query: string): string[] {
	if (!fdPath || !fzfPath) return [];

	const fd = spawnSync(
		fdPath,
		["--base-directory", searchDir, "--type", "f", "--type", "d", "--hidden", "--exclude", ".git"],
		{ encoding: "utf-8" },
	);
	if (fd.status !== 0 || !fd.stdout) return [];

	if (!query) {
		return fd.stdout.split("\n").map((line) => line.trim()).filter(Boolean);
	}

	const fzf = spawnSync(fzfPath, ["--filter", query], {
		encoding: "utf-8",
		input: fd.stdout,
	});

	if ((fzf.status ?? 1) > 1 || !fzf.stdout) return [];
	return fzf.stdout.split("\n").map((line) => line.trim()).filter(Boolean);
}

function toItem(path: string, dirPrefix: string): AutocompleteItem {
	const normalized = path.replace(/\\/g, "/");
	const isDir = normalized.endsWith("/");
	const withoutSlash = isDir ? normalized.slice(0, -1) : normalized;
	const completedPath = dirPrefix + withoutSlash + (isDir ? "/" : "");
	const needsQuotes = completedPath.includes(" ");
	const value = needsQuotes ? `@"${completedPath}"` : `@${completedPath}`;

	return {
		value,
		label: basename(withoutSlash) + (isDir ? "/" : ""),
		description: completedPath,
	};
}

export class FuzzyAtFileAutocompleteProvider implements AutocompleteProvider {
	constructor(
		private readonly inner: AutocompleteProvider,
		private readonly basePath: string,
	) {}

	async getSuggestions(
		lines: string[],
		cursorLine: number,
		cursorCol: number,
		options: { signal: AbortSignal; force?: boolean },
	): Promise<AutocompleteSuggestions | null> {
		const currentLine = lines[cursorLine] ?? "";
		const textBeforeCursor = currentLine.slice(0, cursorCol);
		const atPrefix = extractAtPrefix(textBeforeCursor);

		if (!atPrefix || atPrefix === "@" || !fdPath || !fzfPath) {
			return this.inner.getSuggestions(lines, cursorLine, cursorCol, options);
		}

		const rawQuery = atPrefix.slice(1);
		const { searchDir, fileQuery, dirPrefix } = resolveQueryPath(rawQuery, this.basePath);
		const matches = listMatches(searchDir, fileQuery);
		if (matches.length === 0) return null;

		return {
			items: matches.map((match) => toItem(match, dirPrefix)),
			prefix: atPrefix,
		};
	}

	applyCompletion(lines: string[], cursorLine: number, cursorCol: number, item: AutocompleteItem, prefix: string) {
		return this.inner.applyCompletion(lines, cursorLine, cursorCol, item, prefix);
	}

	shouldTriggerFileCompletion(lines: string[], cursorLine: number, cursorCol: number): boolean {
		return this.inner.shouldTriggerFileCompletion
			? this.inner.shouldTriggerFileCompletion(lines, cursorLine, cursorCol)
			: true;
	}
}

class FuzzyAtFileEditor extends CustomEditor {
	override setAutocompleteProvider(provider: AutocompleteProvider): void {
		super.setAutocompleteProvider(new FuzzyAtFileAutocompleteProvider(provider, process.cwd()));
	}
}

export default function (_pi: ExtensionAPI) {
	if (!fdPath || !fzfPath) return;

	_pi.on("session_start", (_event, ctx) => {
		ctx.ui.setEditorComponent((tui, theme, keybindings) => new FuzzyAtFileEditor(tui, theme, keybindings));
	});
}
