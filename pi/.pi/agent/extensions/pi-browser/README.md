# pi-browser

A local Playwright-powered Pi extension that adds browser automation tools.

## Tools

- `browser_open` — open a URL in Chromium
- `browser_click` — click an element by selector
- `browser_type` — fill/type into an element
- `browser_extract` — extract text or HTML from the current page
- `browser_screenshot` — save a screenshot to disk
- `browser_close` — close the active browser session

## Install

From this directory:

```bash
npm install
```

If Chromium is not available yet, install it with:

```bash
npx playwright install chromium
```

## Notes

- The extension is discovered automatically from `~/.pi/agent/extensions/pi-browser` when this dotfiles package is stowed.
- Browser tools run sequentially so page state is stable across multiple tool calls.
- Screenshots default to `.pi/browser-screenshots/` inside the current working directory.
- Set `PI_BROWSER_HEADFUL=1` to launch a visible browser window instead of headless mode.
