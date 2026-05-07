---
name: mdc
description: Use the `mdc` CLI to publish local Markdown files to Confluence and fetch/pull Confluence pages back into Markdown files. Use when the user asks to publish, update, sync, pull, fetch, or create Confluence pages from markdown, including shorthand like "Publish this KDR".
compatibility: Requires the `mdc` CLI on PATH, the 1Password `op` CLI signed in, and the user's ~/.zshrc `mdc` function for Confluence authentication.
allowed-tools: bash read edit write grep find ls
---

# mdc Confluence Publishing

Use this skill when working with the `mdc` CLI for Confluence-backed Markdown documents.

`mdc` converts between Markdown and Confluence storage format, publishes Markdown files to Confluence, and fetches Confluence pages into Markdown files.

## Authentication and command invocation

In Pi, the bash tool does not automatically load interactive zsh aliases/functions from `~/.zshrc`. The user's authenticated `mdc` wrapper is a zsh function in `~/dotfiles/zsh/.zshrc` / `~/.zshrc`:

- reads the Confluence API token from 1Password with `op read "op://LEGO/Atlassian Api Token For MDC/password"`
- sets `CONFLUENCE_URL="https://legogroup.atlassian.net/wiki"`
- sets `CONFLUENCE_EMAIL="mathias.soholm@lego.com"`
- execs the real `mdc` CLI

When running `mdc` from Pi, prefer the bundled helper script so authentication is available:

```bash
/Users/dkmajuso/.pi/agent/skills/mdc/scripts/mdc-auth --help
/Users/dkmajuso/.pi/agent/skills/mdc/scripts/mdc-auth publish "path/to/file.md" --dry-run
/Users/dkmajuso/.pi/agent/skills/mdc/scripts/mdc-auth fetch "path/to/file.md"
```

Equivalent direct wrapper if needed:

```bash
zsh -ic 'mdc "$@"' mdc publish "path/to/file.md" --dry-run
zsh -ic 'mdc "$@"' mdc fetch "path/to/file.md"
```

Do not print token values. If 1Password is locked or `op` requires authentication, stop and ask the user to unlock/sign in to 1Password.

In command examples below, `mdc ...` shows the CLI shape. In Pi bash executions, use `mdc-auth ...` or the `zsh -ic 'mdc "$@"' mdc ...` wrapper instead of calling bare `mdc`.

## Common Confluence parent IDs

Use these parent IDs when the user refers to the document area by name:

| Name / user wording | Parent ID |
|---|---:|
| KDR folder, KDR | `38086379457` |
| Technical Documents, tech docs, technical docs | `39460667704` |

Examples:
- "Publish this KDR" means publish the target Markdown file under parent `38086379457`, unless the file already has a `page_id` and the user intends an update.
- "Create this under Technical Documents" means use `--parent-id 39460667704`.

## Discover the target file

1. If the user names a file, use that file.
2. If the user says "this file" or similar, infer from the active context when available; otherwise ask for the path.
3. If the user asks to publish a KDR but does not name a file, look for likely KDR Markdown files in the current project before asking for clarification.
4. Prefer exact paths and quote all paths in shell commands.

Useful discovery commands:

```bash
rg --files -g '*.md'
rg -n "^(title|page_id|parent_id|confluence_.*):|^# " --glob '*.md'
```

## Inspect before changing Confluence

Before publishing or fetching:

1. Read the target Markdown file.
2. Check for YAML frontmatter containing Confluence metadata such as `page_id`, `parent_id`, `title`, or similar fields.
3. Determine whether this is an update or a new page:
   - Existing page: file has a page ID, or user supplied a page ID.
   - New page: no page ID; use `--parent-id` and usually `--title` if the title is not clear.
4. If publishing, run `mdc publish --dry-run` first unless the user explicitly asked to skip preview or the workflow is already established.

## Commands

Check the installed CLI and help:

```bash
mdc --help
mdc publish --help
mdc fetch --help
```

### Publish Markdown to Confluence

Update an existing Confluence page when the Markdown file already has page metadata:

```bash
mdc publish "path/to/file.md" --dry-run
mdc publish "path/to/file.md" --message "Update from markdown"
```

Publish/update by explicit page ID:

```bash
mdc publish "path/to/file.md" --page-id PAGE_ID --dry-run
mdc publish "path/to/file.md" --page-id PAGE_ID --message "Update from markdown"
```

Create a new page under a parent:

```bash
mdc publish "path/to/file.md" --parent-id PARENT_ID --title "Page Title" --dry-run
mdc publish "path/to/file.md" --parent-id PARENT_ID --title "Page Title" --message "Initial publish from markdown"
```

Create/publish a KDR:

```bash
mdc publish "path/to/kdr.md" --parent-id 38086379457 --title "KDR Title" --dry-run
mdc publish "path/to/kdr.md" --parent-id 38086379457 --title "KDR Title" --message "Publish KDR from markdown"
```

Create/publish under Technical Documents:

```bash
mdc publish "path/to/doc.md" --parent-id 39460667704 --title "Document Title" --dry-run
mdc publish "path/to/doc.md" --parent-id 39460667704 --title "Document Title" --message "Publish technical document from markdown"
```

Useful publish options:
- `--page-id <PAGE_ID>`: update a specific page; optional if file frontmatter contains page ID.
- `--parent-id <PARENT_ID>`: create a new page under a parent.
- `--title <TITLE>`: override Confluence title.
- `--message <MESSAGE>`: Confluence version message.
- `--dry-run`: preview conversion without uploading.
- `--force`: skip change detection.
- `--no-prompt`: abort on conflict instead of prompting.
- `--verbose`: show progress and summaries.
- `--debug`: show HTTP details; avoid using this in final output because it may expose sensitive details.

### Fetch/pull Confluence changes into Markdown

Fetch into a file that already has page metadata:

```bash
mdc fetch "path/to/file.md"
```

Fetch by explicit page ID into a file:

```bash
mdc fetch "path/to/file.md" --page-id PAGE_ID
```

Overwrite on purpose only when the user confirms or conflict handling is understood:

```bash
mdc fetch "path/to/file.md" --page-id PAGE_ID --force
```

Useful fetch options:
- `--page-id <PAGE_ID>`: download a specific Confluence page; optional if file frontmatter has page ID.
- `--force`: skip conflict detection and overwrite directly.
- `--no-prompt`: abort on conflict instead of prompting.
- `--verbose`: show progress and summaries.

## Title selection

When creating a page and no title is supplied:

1. Prefer frontmatter `title:` if present.
2. Otherwise use the first level-1 heading (`# Title`).
3. Otherwise derive a readable title from the filename.
4. If ambiguity matters, ask the user before publishing.

## Safety and response guidelines

- Never print Confluence API tokens or credential environment values.
- Prefer `--dry-run` before a real publish; summarize dry-run output and ask for confirmation if the user did not clearly authorize publishing.
- If the user explicitly says "publish" or "push" a specific file, it is acceptable to run the real publish after a successful dry run.
- Be careful with `--force`; use it only when the user explicitly requests overwrite/force or after explaining the implication.
- Report the exact command intent, target file, parent/page ID used, and whether the operation was a dry run or real publish/fetch.
- If `mdc` reports conflicts, stop and summarize the conflict. Do not automatically force through conflicts.

## Common request mapping

- "Publish this KDR" → identify the Markdown file, dry-run publish with `--parent-id 38086379457`, then publish if authorized.
- "Publish this technical doc" → identify the Markdown file, dry-run publish with `--parent-id 39460667704`, then publish if authorized.
- "Pull latest from Confluence" → use `mdc fetch` for the file, relying on frontmatter page metadata unless a page ID is supplied.
- "Update the Confluence page" → use `mdc publish` with frontmatter page metadata or an explicit `--page-id`.
