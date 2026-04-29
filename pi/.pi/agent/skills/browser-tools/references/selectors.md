# Selector tips for browser-tools

Use this reference when a page is hard to automate.

## Good default selectors

### Content extraction
- `main`
- `article`
- `[role="main"]`
- `.content`
- `.markdown-body`

### Links and buttons
- `a[href]`
- `button`
- `button[type="submit"]`
- `a[aria-label]`
- `nav a`

### Forms
- `input[name="q"]`
- `input[type="search"]`
- `input[name="email"]`
- `input[name="username"]`
- `textarea`
- `select`

## Strategy for unknown pages

1. Open the page.
2. Extract from `main` as text first.
3. If needed, extract HTML from a focused container.
4. Choose one stable selector from the HTML.
5. Click or type once, then reassess.

## Things to avoid

- Extremely long class chains
- Selectors that depend on sibling order unless necessary
- Random-looking utility classes when a semantic selector exists
- Repeated trial-and-error clicking without inspecting page structure

## Practical examples

### Search forms
- `input[type="search"]`
- `input[name="q"]`
- `form input`

### Package/detail links
- `main a`
- `article a`
- `.packages-grid a`

### Login forms
- `input[name="email"]`
- `input[type="email"]`
- `input[name="login"]`
- `input[type="password"]`
- `button[type="submit"]`
