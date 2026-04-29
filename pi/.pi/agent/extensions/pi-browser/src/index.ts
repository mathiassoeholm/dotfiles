import { mkdtemp, mkdir, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { dirname, join, resolve } from "node:path";

import { StringEnum } from "@mariozechner/pi-ai";
import {
	DEFAULT_MAX_BYTES,
	DEFAULT_MAX_LINES,
	formatSize,
	truncateHead,
	type ExtensionAPI,
	type ExtensionContext,
	type ToolExecutionMode,
	withFileMutationQueue,
} from "@mariozechner/pi-coding-agent";
import { chromium, type Browser, type BrowserContext, type Page } from "playwright";
import { Type } from "typebox";

type WaitUntil = "domcontentloaded" | "load" | "networkidle";
type ExtractFormat = "text" | "html";

interface BrowserPageSummary {
	url: string;
	title: string;
}

interface ExtractDetails extends BrowserPageSummary {
	selector?: string;
	format: ExtractFormat;
	linkCount: number;
	truncated: boolean;
	fullOutputPath?: string;
}

let browser: Browser | null = null;
let context: BrowserContext | null = null;
let page: Page | null = null;

const TOOL_MODE = "sequential" as ToolExecutionMode;
const DEFAULT_TIMEOUT_MS = 15_000;

const waitUntilEnum = StringEnum(["domcontentloaded", "load", "networkidle"] as const, {
	description: "When Playwright should consider navigation complete.",
});

function normalizePath(path: string): string {
	return path.startsWith("@") ? path.slice(1) : path;
}

function normalizeUrl(raw: string): string {
	const value = raw.trim();
	if (/^[a-z][a-z0-9+.-]*:\/\//i.test(value)) return value;
	if (value.includes(" ")) return value;
	return `https://${value}`;
}

function summarizeUrl(url: string): string {
	return url.length > 60 ? `${url.slice(0, 57)}...` : url;
}

function clampTimeout(timeoutMs?: number): number {
	if (!timeoutMs || !Number.isFinite(timeoutMs)) return DEFAULT_TIMEOUT_MS;
	return Math.max(1_000, Math.min(60_000, Math.floor(timeoutMs)));
}

function getHeadlessMode(): boolean {
	return process.env.PI_BROWSER_HEADFUL !== "1";
}

function setStatus(ctx: ExtensionContext, label: string) {
	ctx.ui.setStatus("pi-browser", `🌐 ${label}`);
}

async function ensureContext(): Promise<BrowserContext> {
	if (!browser) {
		browser = await chromium.launch({
			headless: getHeadlessMode(),
		});
	}

	if (!context) {
		context = await browser.newContext({
			viewport: { width: 1440, height: 900 },
		});
		context.setDefaultTimeout(DEFAULT_TIMEOUT_MS);
	}

	return context;
}

async function ensurePage(forceFresh = false): Promise<Page> {
	const activeContext = await ensureContext();

	if (forceFresh && page && !page.isClosed()) {
		await page.close().catch(() => undefined);
		page = null;
	}

	if (!page || page.isClosed()) {
		page = await activeContext.newPage();
	}

	return page;
}

function requirePage(): Page {
	if (!page || page.isClosed()) {
		throw new Error("No active page. Call browser_open first.");
	}
	return page;
}

async function currentSummary(activePage: Page): Promise<BrowserPageSummary> {
	return {
		url: activePage.url(),
		title: await activePage.title(),
	};
}

async function captureContent(activePage: Page, selector?: string) {
	return activePage.evaluate((selected) => {
		const root = selected ? document.querySelector(selected) : document.body;
		if (!root) {
			return { found: false, text: "", html: "", links: [] as Array<{ text: string; href: string }> };
		}

		const linkMap = new Map<string, { text: string; href: string }>();
		for (const link of Array.from(root.querySelectorAll("a[href]"))) {
			const href = link.getAttribute("href") ?? "";
			const absoluteHref = (link as HTMLAnchorElement).href || href;
			const text = (link.textContent ?? "").trim().replace(/\s+/g, " ");
			if (!absoluteHref) continue;
			if (!linkMap.has(absoluteHref)) {
				linkMap.set(absoluteHref, { text, href: absoluteHref });
			}
		}

		const htmlRoot = root as HTMLElement;
		return {
			found: true,
			text: (htmlRoot.innerText ?? "").trim(),
			html: htmlRoot.outerHTML,
			links: Array.from(linkMap.values()).slice(0, 50),
		};
	}, selector);
}

async function closeBrowser(ctx?: ExtensionContext) {
	if (page && !page.isClosed()) {
		await page.close().catch(() => undefined);
	}
	page = null;

	if (context) {
		await context.close().catch(() => undefined);
	}
	context = null;

	if (browser) {
		await browser.close().catch(() => undefined);
	}
	browser = null;

	if (ctx) setStatus(ctx, "idle");
}

async function buildExtractResult(
	content: string,
	details: Omit<ExtractDetails, "truncated" | "fullOutputPath">,
) {
	const truncation = truncateHead(content, {
		maxLines: DEFAULT_MAX_LINES,
		maxBytes: DEFAULT_MAX_BYTES,
	});

	const result: ExtractDetails = {
		...details,
		truncated: truncation.truncated,
	};

	let text = truncation.content;
	if (truncation.truncated) {
		const tempDir = await mkdtemp(join(tmpdir(), "pi-browser-"));
		const tempFile = join(tempDir, "extract.txt");
		await withFileMutationQueue(tempFile, async () => {
			await writeFile(tempFile, content, "utf8");
		});
		result.fullOutputPath = tempFile;
		text += `\n\n[Output truncated: showing ${truncation.outputLines} of ${truncation.totalLines} lines (${formatSize(truncation.outputBytes)} of ${formatSize(truncation.totalBytes)}). Full output saved to: ${tempFile}]`;
	}

	return {
		content: [{ type: "text", text }],
		details: result,
	};
}

export default function (pi: ExtensionAPI) {
	pi.on("session_start", async (_event, ctx) => {
		setStatus(ctx, "idle");
	});

	pi.on("session_shutdown", async (_event, ctx) => {
		await closeBrowser(ctx);
	});

	pi.registerCommand("browser-reset", {
		description: "Close the active Playwright browser session",
		handler: async (_args, ctx) => {
			await closeBrowser(ctx);
			ctx.ui.notify("Browser session closed", "info");
		},
	});

	pi.registerTool({
		name: "browser_open",
		label: "Browser Open",
		description: "Open a URL in a Playwright-controlled Chromium page. Use this before browser_click, browser_type, browser_extract, or browser_screenshot.",
		promptSnippet: "Open a URL in a Playwright-controlled Chromium page",
		promptGuidelines: [
			"Use browser_open before browser_click, browser_type, browser_extract, or browser_screenshot when there is no active page.",
		],
		parameters: Type.Object({
			url: Type.String({ description: "The URL to open. If no scheme is given, https:// is assumed." }),
			waitUntil: Type.Optional(waitUntilEnum),
			freshPage: Type.Optional(Type.Boolean({ description: "Close any previous active page and start from a fresh tab." })),
		}),
		executionMode: TOOL_MODE,
		async execute(_toolCallId, params, _signal, onUpdate, ctx) {
			onUpdate?.({ content: [{ type: "text", text: "Launching browser..." }] });
			const activePage = await ensurePage(Boolean(params.freshPage));
			const url = normalizeUrl(params.url);
			const waitUntil = (params.waitUntil ?? "load") as WaitUntil;
			const response = await activePage.goto(url, { waitUntil });
			const summary = await currentSummary(activePage);
			setStatus(ctx, summary.title || summarizeUrl(summary.url));
			return {
				content: [
					{
						type: "text",
						text:
							`Opened ${summary.url}\n` +
							`Title: ${summary.title || "(untitled)"}\n` +
							`Status: ${response?.status() ?? "unknown"}`,
					},
				],
				details: {
					...summary,
					status: response?.status() ?? null,
				},
			};
		},
	});

	pi.registerTool({
		name: "browser_click",
		label: "Browser Click",
		description: "Click an element on the current page using a CSS selector.",
		promptSnippet: "Click an element on the current Playwright page by selector",
		parameters: Type.Object({
			selector: Type.String({ description: "CSS selector to click" }),
			waitUntil: Type.Optional(waitUntilEnum),
			timeoutMs: Type.Optional(Type.Number({ description: "Optional timeout in milliseconds" })),
			doubleClick: Type.Optional(Type.Boolean({ description: "Use a double click instead of a single click." })),
		}),
		executionMode: TOOL_MODE,
		async execute(_toolCallId, params, _signal, onUpdate, ctx) {
			const activePage = requirePage();
			onUpdate?.({ content: [{ type: "text", text: `Clicking ${params.selector}...` }] });
			const locator = activePage.locator(params.selector).first();
			const timeout = clampTimeout(params.timeoutMs);
			if (params.doubleClick) {
				await locator.dblclick({ timeout });
			} else {
				await locator.click({ timeout });
			}
			if (params.waitUntil) {
				await activePage.waitForLoadState(params.waitUntil as WaitUntil, { timeout });
			}
			const summary = await currentSummary(activePage);
			setStatus(ctx, summary.title || summarizeUrl(summary.url));
			return {
				content: [{ type: "text", text: `Clicked ${params.selector} on ${summary.url}` }],
				details: {
					...summary,
					selector: params.selector,
					doubleClick: Boolean(params.doubleClick),
				},
			};
		},
	});

	pi.registerTool({
		name: "browser_type",
		label: "Browser Type",
		description: "Fill or type text into an element on the current page using a CSS selector.",
		promptSnippet: "Fill or type text into the current Playwright page by selector",
		parameters: Type.Object({
			selector: Type.String({ description: "CSS selector to target" }),
			text: Type.String({ description: "Text to type or fill" }),
			clearFirst: Type.Optional(Type.Boolean({ description: "Clear the field before entering text. Defaults to true." })),
			pressEnter: Type.Optional(Type.Boolean({ description: "Press Enter after typing." })),
			timeoutMs: Type.Optional(Type.Number({ description: "Optional timeout in milliseconds" })),
		}),
		executionMode: TOOL_MODE,
		async execute(_toolCallId, params, _signal, onUpdate, ctx) {
			const activePage = requirePage();
			onUpdate?.({ content: [{ type: "text", text: `Typing into ${params.selector}...` }] });
			const locator = activePage.locator(params.selector).first();
			const timeout = clampTimeout(params.timeoutMs);
			const clearFirst = params.clearFirst ?? true;
			if (clearFirst) {
				await locator.fill(params.text, { timeout });
			} else {
				await locator.focus({ timeout });
				await locator.type(params.text, { timeout });
			}
			if (params.pressEnter) {
				await locator.press("Enter", { timeout });
			}
			const summary = await currentSummary(activePage);
			setStatus(ctx, summary.title || summarizeUrl(summary.url));
			return {
				content: [{ type: "text", text: `Entered text into ${params.selector} on ${summary.url}` }],
				details: {
					...summary,
					selector: params.selector,
					textLength: params.text.length,
					pressEnter: Boolean(params.pressEnter),
				},
			};
		},
	});

	pi.registerTool({
		name: "browser_extract",
		label: "Browser Extract",
		description: `Extract text or HTML from the current page. Output is truncated to ${DEFAULT_MAX_LINES} lines or ${formatSize(DEFAULT_MAX_BYTES)} (whichever is hit first).`,
		promptSnippet: "Extract text or HTML from the current Playwright page",
		parameters: Type.Object({
			selector: Type.Optional(Type.String({ description: "Optional CSS selector to extract from instead of the whole page body" })),
			format: Type.Optional(
				StringEnum(["text", "html"] as const, {
					description: "Return plain text or raw HTML",
				}),
			),
			includeLinks: Type.Optional(Type.Boolean({ description: "Append a short list of links found in the selected content." })),
		}),
		executionMode: TOOL_MODE,
		async execute(_toolCallId, params, _signal, onUpdate, ctx) {
			const activePage = requirePage();
			onUpdate?.({ content: [{ type: "text", text: "Extracting page content..." }] });
			const result = await captureContent(activePage, params.selector);
			if (!result.found) {
				throw new Error(
					params.selector
						? `Selector not found: ${params.selector}`
						: "No content available on the current page.",
				);
			}
			const summary = await currentSummary(activePage);
			setStatus(ctx, summary.title || summarizeUrl(summary.url));

			const format = (params.format ?? "text") as ExtractFormat;
			let output = format === "html" ? result.html : result.text;

			if (params.includeLinks && result.links.length > 0) {
				const linksText = result.links
					.map((link, index) => `${index + 1}. ${link.text || "(no text)"} — ${link.href}`)
					.join("\n");
				output += `\n\nLinks:\n${linksText}`;
			}

			return buildExtractResult(output, {
				...summary,
				selector: params.selector,
				format,
				linkCount: result.links.length,
			});
		},
	});

	pi.registerTool({
		name: "browser_screenshot",
		label: "Browser Screenshot",
		description: "Save a screenshot of the current page to disk.",
		promptSnippet: "Save a screenshot of the current Playwright page to disk",
		parameters: Type.Object({
			path: Type.Optional(Type.String({ description: "Output path for the PNG file. Defaults to .pi/browser-screenshots/<timestamp>.png in the current working directory." })),
			fullPage: Type.Optional(Type.Boolean({ description: "Capture the full page instead of only the visible viewport." })),
		}),
		executionMode: TOOL_MODE,
		async execute(_toolCallId, params, _signal, onUpdate, ctx) {
			const activePage = requirePage();
			onUpdate?.({ content: [{ type: "text", text: "Capturing screenshot..." }] });

			const relativePath = normalizePath(
				params.path ?? `.pi/browser-screenshots/browser-${Date.now()}.png`,
			);
			const absolutePath = resolve(ctx.cwd, relativePath);

			await withFileMutationQueue(absolutePath, async () => {
				await mkdir(dirname(absolutePath), { recursive: true });
				await activePage.screenshot({
					path: absolutePath,
					fullPage: params.fullPage ?? true,
					type: "png",
				});
			});

			const summary = await currentSummary(activePage);
			setStatus(ctx, summary.title || summarizeUrl(summary.url));
			return {
				content: [{ type: "text", text: `Saved screenshot to ${relativePath}` }],
				details: {
					...summary,
					path: relativePath,
					fullPage: params.fullPage ?? true,
				},
			};
		},
	});

	pi.registerTool({
		name: "browser_close",
		label: "Browser Close",
		description: "Close the active Playwright browser session and clear its page state.",
		promptSnippet: "Close the active Playwright browser session",
		parameters: Type.Object({}),
		executionMode: TOOL_MODE,
		async execute(_toolCallId, _params, _signal, _onUpdate, ctx) {
			await closeBrowser(ctx);
			return {
				content: [{ type: "text", text: "Closed the active browser session" }],
				details: {},
			};
		},
	});
}
