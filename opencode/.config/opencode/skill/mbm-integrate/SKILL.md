---
name: mbm-integrate
description: Use when working on MBM codebase and code changes are ready to integrate into main branch
---

# MBM CLI Integrate

Integrates uncommitted changes on `main` into an auto-merged PR. One command handles branch creation, commit, push, PR, auto-merge monitoring, and cleanup.

## CRITICAL: User Review Required

**NEVER proceed without explicit user approval.** AI-generated code must be reviewed line-by-line.

```
┌─────────────────────────────┐
│ Code changes complete       │
└──────────────┬──────────────┘
               ▼
┌─────────────────────────────┐
│ Show diff to user           │
│ (git status && git diff)    │
└──────────────┬──────────────┘
               ▼
┌─────────────────────────────┐
│ Ask user to review and      │
│ approve changes             │
└──────────────┬──────────────┘
               ▼
        ┌──────────────┐
        │ User approves?│
        └──────┬───────┘
          no   │   yes
          ▼    │    ▼
       STOP    │  ┌─────────────────────────────┐
               │  │ Propose commit message      │
               └─►│ Wait for approval or        │
                  │ alternative                 │
                  └──────────────┬──────────────┘
                                 ▼
                          ┌──────────────┐
                          │ User approves?│
                          └──────┬───────┘
                      alternative│   yes
                            ▼    │    ▼
                    Use user's   └──► mbm integrate "message"
                    wording exactly
```

**Approval phrases**: "approve", "approved", "yes", "go ahead", "lgtm", "looks good, proceed"

**NOT approval**: Silence, ambiguous responses, "looks interesting", "ok" without context

## When to Suggest Integration

Proactively suggest after completing:
- A feature or enhancement
- A bug fix
- A refactor
- Any logical unit of work

**Philosophy**: Integrate early and often. Small atomic changes are easier to review and revert.

## Quick Reference

| Command                            | Description                  |
| ---------------------------------- | ---------------------------- |
| `mbm integrate "message"`          | Create auto-merged PR        |
| `mbm integrate "message" --no-merge` | Create PR without auto-merge |

## Preconditions

Must be true before running:
- On `main` branch
- Local main up to date with `origin/main`
- Uncommitted changes exist

## Workflow

1. Complete code changes
2. Run `git status` and `git diff` - show output to user
3. **STOP** - Ask user to review and approve the changes
4. Wait for explicit approval (see phrases above)
5. Propose a commit message
6. **STOP** - Wait for user to approve the message or provide an alternative
7. Run `mbm integrate "approved message"` with a **10 minute timeout** (600000ms)
8. Command monitors PR until merged or failed

## Error Handling

| Error                            | Fix                                |
| -------------------------------- | ---------------------------------- |
| "Current branch is not 'main'"   | `git checkout main`                |
| "Local branch is not up to date" | `git pull`                         |
| "No changes to integrate"        | Nothing to do                      |
| Required check fails             | Fix the issue, run integrate again |

## CRITICAL: Never Bypass the MBM CLI

**If the `mbm integrate` command fails for any reason, do NOT fall back to standard git commands (git commit, git push, gh pr create, etc.).**

Instead:
1. Stop immediately
2. Report the exact error to the user
3. Let the user decide how to proceed

The MBM CLI provides important guardrails and consistency. Silently working around failures defeats its purpose and can leave the repository in an unexpected state.

## Commit Messages

Keep it short - one or two sentences describing the change.

**Propose the message and wait for explicit approval.** If the user provides an alternative, use their wording exactly.

## When NOT to Use

- When on a feature branch (use normal git workflow instead)
