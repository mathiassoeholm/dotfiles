---
name: grill-with-docs
description: Grilling session for MBM that challenges a plan against the existing domain model, sharpens terminology using UBIQUITOUS_LANGUAGE.md, and updates MBM docs/KDRs as decisions crystallise. Use when the user wants to stress-test a plan against MBM's language and documented decisions.
allowed-tools: bash read edit write grep find ls
---

# Grill With Docs for MBM

<what-to-do>

## Target input

This skill is usually invoked with a target, similar to the `grill-me` prompt:

```text
/skill:grill-with-docs <target>
```

The target is the plan, design, decision, KDR, Brief, code path, or proposed change to stress-test. Pi appends skill command arguments to the skill content as a user message; treat those arguments as the target.

If a target is provided:

1. Restate the target briefly.
2. Identify the first branch of the decision tree to grill.
3. Start with exactly one high-leverage question and your recommended answer.

If no target is provided, ask the user for the target before beginning.

## Grilling loop

Interview me relentlessly about every aspect of the target until we reach a shared understanding. Walk down each branch of the design tree, resolving dependencies between decisions one-by-one. For each question, provide your recommended answer.

Ask the questions one at a time, waiting for feedback on each question before continuing.

If a question can be answered by exploring the codebase, explore the codebase instead.

Continue until the target has been thoroughly stress-tested and the major assumptions, risks, tradeoffs, documentation updates, and open decisions are explicit.

</what-to-do>

<supporting-info>

## MBM domain awareness

During codebase exploration, also look for existing documentation:

- `UBIQUITOUS_LANGUAGE.md` at the repository root is the single canonical glossary for MBM language. Use it instead of `CONTEXT.md`; do not look for or create `CONTEXT.md` or `CONTEXT-MAP.md`.
- `docs/kdr/` contains Knowledge Decision Records. Use KDRs instead of ADRs; do not create `docs/adr/`.
- Relevant feature briefs and technical docs may live under `docs/feature_briefs/`, `docs/mbm-arch/`, and `agents/docs/`. Load only the docs relevant to the plan being grilled.
- Follow the repo's `AGENTS.md` routing instructions when the discussion touches architecture, API behavior, domain, application, infrastructure, Temporal, or frontend concerns.

### File structure

MBM has one repo-level ubiquitous language file and one KDR directory:

```text
/
├── UBIQUITOUS_LANGUAGE.md
├── docs/
│   └── kdr/
│       ├── kdr-25-extracting-bff-endpoints-from-mbm-api.md
│       ├── kdr-26-model-design-format-versioning-api.md
│       └── ...
└── src/
```

Create files lazily — only when there is something concrete to write. `UBIQUITOUS_LANGUAGE.md` already exists in this repo; update it inline when a term is resolved. Create a new KDR in `docs/kdr/` only when a decision genuinely needs a durable record.

## During the session

### Challenge against the ubiquitous language

When the user uses a term that conflicts with `UBIQUITOUS_LANGUAGE.md`, call it out immediately:

> Your Ubiquitous Language defines **BuildDesign** as a structural grouping inside a **ModelDesign Version**, but you seem to mean the generated file. Do you mean **BuildDesign** or **BuildDesign LXFML Artifact**?

### Sharpen fuzzy language

When the user uses vague or overloaded terms, propose a precise canonical term from `UBIQUITOUS_LANGUAGE.md`, or propose a new canonical term if none exists:

> You're saying "model" — do you mean **ModelDesign**, **ModelDesign Version**, **BuildDesign**, or a schema/entity type? Those are different concepts in MBM.

### Discuss concrete scenarios

When domain relationships are being discussed, stress-test them with specific scenarios. Invent scenarios that probe edge cases and force precision about boundaries between MBM concepts.

Examples:

- A **SetDesign** references the same **ModelDesign** as another **SetDesign** but owns a different **Inventory**.
- A **ModelDesign Version** contains multiple **BuildDesigns**, each with separate **BuildDesign LXFML Artifacts**.
- A **PlacedPart** and a **ModelElement** are accidentally treated as the same concept.
- A **Source Artifact** and an **Original Upload Artifact** are confused during format conversion or retrieval.

### Cross-reference with code and docs

When the user states how something works, check whether the code and docs agree. If you find a contradiction, surface it:

> The KDR says metadata deletes remain idempotent, but this handler returns an error for absent keys — which behaviour should be canonical?

Prefer codebase exploration over asking when the answer is discoverable. Use the smallest relevant search/read needed.

### Update UBIQUITOUS_LANGUAGE.md inline

When a term is resolved, update `UBIQUITOUS_LANGUAGE.md` right there. Don't batch these up — capture them as they happen. Use the format in [UBIQUITOUS_LANGUAGE-FORMAT.md](./UBIQUITOUS_LANGUAGE-FORMAT.md).

`UBIQUITOUS_LANGUAGE.md` should be a glossary and relationship map for MBM domain language. Do not treat it as a scratch pad, implementation spec, delivery plan, or KDR substitute.

### Offer KDRs sparingly

Only offer to create or update a KDR when all three are true:

1. **Hard to reverse** — the cost of changing your mind later is meaningful.
2. **Surprising without context** — a future reader will wonder "why did we do it this way?".
3. **The result of a real trade-off** — there were genuine alternatives and one was picked for specific reasons.

If any of the three is missing, skip the KDR. Use the format in [KDR-FORMAT.md](./KDR-FORMAT.md).

When a discussion changes API behavior at the feature/capability level, also update `docs/feature_briefs/api-main-brief.md` in the same change, per repo instructions.

</supporting-info>
