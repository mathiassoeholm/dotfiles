# KDR Format

KDRs live in `docs/kdr/` and use the existing MBM naming pattern:

```text
docs/kdr/kdr-{number}-{slug}.md
```

Examples:

- `docs/kdr/kdr-25-extracting-bff-endpoints-from-mbm-api.md`
- `docs/kdr/kdr-26-model-design-format-versioning-api.md`
- `docs/kdr/kdr-32-v2-metadata-createdby-write-contract.md`

Create a KDR lazily — only when a decision genuinely needs a durable record.

## Numbering

Scan `docs/kdr/` for the highest existing `kdr-NN-...md` number and increment by one.

If the next number is ambiguous because duplicate local/remote files exist, ask before creating the new KDR.

## Frontmatter

Existing KDRs often contain Confluence metadata frontmatter after publishing. For a new local KDR, do not invent `page_id` or `version` values.

If Confluence publishing is needed, use the `mdc` skill/workflow. Otherwise, a new KDR can start directly with a title.

## Recommended template

Use the sections that fit the decision. Keep the record concise, but preserve the reasoning and trade-offs.

```md
# KDR-{number} {Title}

## Status

> [!WARNING]
> Open for team input. No decision has been made yet.
```

Once decided, use:

```md
> [!DECISION]
> We will {decision summary}.
```

Then include whichever sections are useful:

```md
## Problem

What pressure, ambiguity, or decision point caused this KDR to exist?

## Context

Relevant constraints, current behavior, links to existing docs/KDRs, and facts discovered from the codebase.

## Options

### Option 1: {Name}

Short description.

**Pros**

- ...

**Cons**

- ...

### Option 2: {Name}

...

## Decision

> [!DECISION]
> We will {chosen option and the key consequence}.

## Rationale

Why this option best fits MBM's domain language, architecture, API contract, operational constraints, or migration path.

## Consequences

- What becomes easier?
- What becomes harder?
- What follow-up work is required?
```

## When to offer a KDR

All three of these must be true:

1. **Hard to reverse** — the cost of changing your mind later is meaningful.
2. **Surprising without context** — a future reader will look at the code/docs and wonder "why on earth did we do it this way?".
3. **The result of a real trade-off** — there were genuine alternatives and one was picked for specific reasons.

If a decision is easy to reverse, skip it. If it is not surprising, skip it. If there was no real alternative, capture it in the appropriate Brief/Plan/code comment/test instead.

## What qualifies

- Architectural shape or layer boundaries in MBM's hexagonal architecture.
- API contract shape, route structure, status/body/auth-visible behavior, or compatibility decisions.
- Persistence, workflow, integration, or infrastructure choices with meaningful lock-in.
- Boundary and ownership decisions between concepts like **SetDesign**, **ModelDesign**, **ModelDesign Version**, **BuildDesign**, **Inventory**, and artifacts.
- Deliberate deviations from the expected path.
- Constraints not visible in the code, such as consumer compatibility, compliance, operational limitations, or Confluence/API publication constraints.
- Rejected alternatives when the rejection is non-obvious and likely to be revisited.

## KDR vs UBIQUITOUS_LANGUAGE.md

- Use `UBIQUITOUS_LANGUAGE.md` for stable domain terms, definitions, aliases to avoid, relationships, examples, and flagged ambiguities.
- Use a KDR for why a significant decision was made among alternatives.
- If a KDR resolves new terminology, update `UBIQUITOUS_LANGUAGE.md` inline as part of the same session.
- If a KDR changes API behavior at the feature/capability level, update `docs/feature_briefs/api-main-brief.md` as required by the repo instructions.
