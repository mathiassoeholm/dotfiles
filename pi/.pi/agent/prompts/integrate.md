---
description: Review the current git change set, confirm a short commit message, keep the current branch/worktree, then run `mbm --agent integrate` with the right flags.
---

Integrate the current work using the MBM CLI only. Follow this exact workflow:

Output rules:

- Minimize your output.
- Do not mention which code changes were made.
- Only ask short questions, for example whether the proposed commit message is okay.

1. Inspect the current state.
   - Run `git add .` first so the review matches what `mbm integrate` will include.
   - Run `git add .` as its own separate command.
   - After that, run `git status --short` and `git diff --cached`.
   - Detect the current branch with `git rev-parse --abbrev-ref HEAD`.
   - Detect whether the current directory is a git worktree with:
     - `git rev-parse --git-dir`
     - `git rev-parse --git-common-dir`
2. If the current branch is not `main`, also inspect the branch-level delta with `git diff origin/main...HEAD`.
   - Run `git fetch origin main` first so `origin/main` reflects the latest remote state, not a stale local ref.
3. Use the combined picture of staged local changes and, on feature branches, the full `origin/main...HEAD` diff to produce:
   - a brief summary of the work
   - a commit message of max 50 characters (hard limit: 72), imperative mood, no trailing period
     - Example: "Add LXFML status inference" not "Implement LXFML status inference from per-BuildDesign artifacts..."
4. STOP and ask whether the proposed commit message is appropriate.
   - Do not continue until the user explicitly approves the message or provides replacement wording.
   - If the user provides a replacement, use it exactly.
5. Build a short PR body directly.
   - Include a `## Summary` section with a concise explanation of what changed and why.
   - Keep it brief and do not use `.github/pull_request_template.md`.
6. If the current directory is a worktree or the current branch is not `main`, assume the user wants to keep the current branch/worktree after integration and include `--return-to-branch`.
7. Run `mbm --agent integrate "<approved-commit-message>" --yes --include-uncommitted --body "<pr-body>"`.
   - Add `--return-to-branch` when the current directory is a worktree or the current branch is not `main`.
8. Use a 15 minute timeout for the `mbm` command.
9. Never replace this workflow with manual `git commit`, `git push`, `gh pr create`, or any other git/GitHub fallback.
