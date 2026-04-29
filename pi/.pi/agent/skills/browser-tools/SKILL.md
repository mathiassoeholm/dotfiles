---
name: browser-tools
description: Use the local Playwright browser tools to browse websites, navigate pages, extract visible text or HTML, take screenshots, and fill simple forms. Use when the user asks to inspect a live website, click through a flow, capture a screenshot, or read content that requires a real browser.
license: MIT
compatibility: Requires the local pi-browser extension to be installed and loaded so browser_open, browser_click, browser_type, browser_extract, browser_screenshot, and browser_close are available.
allowed-tools: browser_open browser_click browser_type browser_extract browser_screenshot browser_close read
---

# Browser Tools

Use this skill when the task requires interacting with a real website in a browser.

The companion extension provides these tools:
- `browser_open`
- `browser_click`
- `browser_type`
- `browser_extract`
- `browser_screenshot`
- `browser_close`

Read [selector tips](references/selectors.md) when a page is tricky to automate.

## Core workflow

1. Open the page with `browser_open`.
2. If the user wants content from the page, use `browser_extract`.
3. If the user wants navigation or form interaction, use `browser_click` and `browser_type`.
4. If the user wants visual output, use `browser_screenshot`.
5. Report exactly what happened, including paths for saved screenshots.
6. If the session is clearly finished or the page state is broken, use `browser_close`.

## Tool usage rules

### 1. Always start with `browser_open` when no page is active

Use `browser_open` before any click, type, extract, or screenshot operation when there is no active page.

- If the user gives a bare hostname like `pi.dev`, pass it as-is; the tool will normalize it.
- Use `freshPage: true` when the task should start from a clean tab or when the previous page state is likely irrelevant.
- Prefer `waitUntil: "load"` by default.
- Use `waitUntil: "networkidle"` for SPA-style pages that continue loading after the first paint.

### 2. Prefer extraction over screenshots for textual questions

If the user asks things like:
- “summarize this page”
- “what packages are listed?”
- “extract the main text”

then use `browser_extract` instead of only taking a screenshot.

Defaults:
- Use `format: "text"` unless the user explicitly wants HTML.
- Prefer extracting from `main`, `article`, or another narrow content selector when possible.
- Set `includeLinks: true` when links are relevant to the answer.

### 3. Use screenshots for visual confirmation

Use `browser_screenshot` when the user asks for:
- a screenshot
- visual confirmation
- a saved artifact
- debugging of layout/UI state

Defaults:
- Use `fullPage: true` unless the user clearly wants only the viewport.
- If no path is requested, let the tool choose the default path.
- Always report the saved path back to the user.

### 4. Use stable selectors when clicking or typing

Prefer selectors in roughly this order:
1. specific semantic selectors already provided by the user
2. `main`, `article`, `nav`, `header`, `footer`
3. form selectors such as `input[name="email"]`, `button[type="submit"]`
4. IDs and stable classes
5. broader selectors only as a last resort

Avoid brittle selectors that look machine-generated unless there is no better option.

### 5. When a selector is uncertain, inspect first

If you are unsure what to click or extract:
- first extract from a broader container such as `main`
- or extract page HTML from a focused container
- then choose a more specific selector

Do not blindly spam many clicks. Use one or two deliberate inspection steps.

### 6. Be explicit about page state changes

After a click or type action, mention what page or state you expect next.
For example:
- clicking a package link and then extracting the package details
- typing into a search field and pressing Enter before extracting results

### 7. Close the session when appropriate

Use `browser_close` when:
- the user explicitly asks to close the browser
- the task is complete and the browser session is no longer useful
- the browser state is clearly stuck and a reset is the cleanest path

Do not close the session too early if more browsing steps are likely.

## Common patterns

### Read and summarize a page

1. `browser_open`
2. `browser_extract` with `selector: "main"`, `format: "text"`
3. summarize results for the user

### Save a screenshot of a page

1. `browser_open`
2. `browser_screenshot` with `fullPage: true`
3. report the output path

### Fill a search field and inspect results

1. `browser_open`
2. `browser_type` into the search input, often with `pressEnter: true`
3. `browser_extract` from `main` or the results container

### Click through to a detail page

1. `browser_open`
2. `browser_click` on a stable selector
3. `browser_extract` or `browser_screenshot` on the resulting page

## Response guidelines

When using these tools, tell the user:
- what page you opened
- what you clicked or typed, if relevant
- what you extracted or saved
- screenshot paths exactly, when applicable
- any limitations, such as truncated extraction or missing selectors

## Example requests this skill should handle well

- “Open https://pi.dev/packages and tell me the top packages shown.”
- “Take a full-page screenshot of this docs page.”
- “Open the login page and fill the email field with test@example.com.”
- “Browse to the package catalog, open the permissions-related package, and summarize it.”

## If the user forces this skill manually

The user may invoke this skill with `/skill:browser-tools ...`.
Treat any appended user arguments as the browsing task to complete using the browser tools above.
