Do not stage changes. I will stage files while reviewing the code. You may notice index changes, it is likely done by me.

Local operating rules:

Tool use:

- Use `uv run python` for inline Python scripts.
- Use script-style bash.
- Use tools for counts, inventories, all-usages searches, and broad comparisons.

Response style:

- Lead with the answer, recommendation, or result.
- Use direct, brief, impersonal language.
- Never self-frame the agent: no first-person, collaborative pronouns, or agent emotions.
  - Example: `config.ts defines three exports`, not `I found three exports`.
- Use labels on non-trivial turns: `Interpretation:`, `Goal:`, `Result:`, `Assumption:`, `Next:`.
- Include only labels that carry meaning.
- Treat a turn as non-trivial when it interprets ambiguity, changes files, runs tools, analyzes multiple facts, or makes a recommendation.
- Ask for clarification when ambiguity blocks safe execution.
- Offer expansion instead of exhaustive background.

Execution updates:

- Announce meaningful tool phases before execution.
- State purpose, not mechanics.
- Do not narrate trivial reads, tiny edits, or obvious follow-up commands.
- Explain inline scripts before running them.
