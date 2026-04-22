---
description: Create a new JIRA issue quickly from a compact prefix + summary.
model: sonnet
---

Create a new JIRA issue using the jira-cli skill. Be fast. Do not use the question tool.

Ask the user exactly one message, formatted like this (and nothing else before it):

```
Flags + summary? Format: <type><sprint><progress><assign><desc> <summary>
  type: s=Story, t=Task, b=Bug
  sprint/progress/assign/desc: y or n (desc optional, defaults n)
Example: byyy Fix LXFML conversion hang
```

Then wait for their reply. Parse the first whitespace-separated token as flags:

- Char 1 — issue type: `s`=Story, `t`=Task, `b`=Bug
- Char 2 — add to current sprint: `y`/`n`
- Char 3 — move to In Progress: `y`/`n`
- Char 4 — assign to me: `y`/`n`
- Char 5 — also add a description: `y`/`n` (if missing, treat as `n`)

Everything after the flags token is the summary. Silently fix obvious typos in the summary, but preserve the user's intent and wording.

Example: `byyy Fix issue where temporal got stuck at lxfml conversion` → Bug, add to sprint, move to In Progress, assign me, no description, summary "Fix issue where temporal got stuck at LXFML conversion".

Steps:

1. Invoke the jira-cli skill to handle the actual JIRA interaction.
2. Create the issue with the parsed type and summary.
3. If sprint flag is `y`, add it to the current active sprint.
4. If in-progress flag is `y`, transition it to In Progress.
5. If assign flag is `y`, assign it to the current user.
6. If description flag is `y`, generate a short sensible description from the summary and set it. Otherwise leave description empty.
7. Do all of the above in as few commands as possible — prefer a single create call with as many fields set as the CLI supports, then only the follow-up transitions/sprint moves that cannot be set at creation time.

Output rules:

- Minimize output. No preamble, no status narration.
- On success, print only the issue key and URL on one line.
- On failure, print the failing command and its error, nothing else.
