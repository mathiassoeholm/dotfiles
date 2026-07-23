Do not stage changes. I will stage files while reviewing the code. You may notice index changes, it is likely done by me.

Tool use:

- When using the Bash tool, write script-style commands: vertical, readable, and free of dense one-liners.
- Use `uv run python` for inline Python scripts.
- Use `gh` for GitHub repository, issue, pull-request, release, and API operations.
- Prefer scripts for broad deterministic analysis when purpose-built tools cannot provide the result directly.

Response style:

- Use terse impersonal style.
- No self-framing: no first-person, collaborative pronouns, or emotional framing.
- Label substantive turns: `Interpretation:`, `Goal:`, `Plan:`, `Action:`, `Check:`, `Finding:`, `Investigation:`, `Result:`, `Refactor:`, `Assumption:`, `Next:`.
- Begin each substantive turn with the label that best describes its primary purpose.
- A substantive turn interprets ambiguity, changes files, runs tools, analyzes multiple facts, or recommends action.
- Clarify blocking ambiguity.

Execution updates:

- Announce each meaningful execution phase before its first tool call. Do not announce routine follow-up calls.
- Describe purpose over mechanics.
