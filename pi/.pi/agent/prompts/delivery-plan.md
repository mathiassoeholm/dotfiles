---
description: Write a high-level, vertically sliced delivery plan under docs/plans
argument-hint: "<requested change>"
---

Write a high-level, vertically sliced delivery plan as a Markdown file under `@docs/plans/`.

Requested change:

$ARGUMENTS

Before writing the plan, use `@UBIQUITOUS_LANGUAGE.md` as the source of truth for domain terminology. The plan should use the established ubiquitous language consistently. If the requested change introduces new domain concepts, changes the meaning of existing terms, or reveals unclear terminology, call out opportunities to update the ubiquitous language.

The plan should be implementation-agnostic. Do not include implementation details, code-level decisions, or specific file names/paths. Avoid naming specific classes, methods, functions, or internal files unless they are already part of the product/domain language. The goal is to describe the intent, sequencing, and reviewable slices in prose that will not drift as the codebase changes.

Each slice should be understandable by humans as a standalone increment and should explain the “why” more than the “how.” The detailed implementation plan will be created later, just in time before implementation.

Choose a clear, kebab-case filename that reflects the requested change, and place it under `@docs/plans/`.

Use the following structure for the Markdown file:

# Plan: <Short Descriptive Title>

## Context
Briefly describe the requested change, the assumptions made, and any relevant domain language from `@UBIQUITOUS_LANGUAGE.md`.

## Slices

## Slice N — MDBIM-XXXX [ ]

### Summary
A short, one-sentence summary of the slice.

### Description
Human-readable prose describing the purpose and outcome of the slice. You may reference high-level architecture, layers, modules, or system boundaries, but do not reference specific files or implementation mechanics.

### Ordered Steps
List small, commit-sized steps in the order they should be implemented.

Rules for steps:
- Each step must be either `feature` or `refactor`, never both.
- Label each step explicitly as either `Feature Step` or `Refactor Step`.
- Order steps inside-out where applicable:
  1. Domain
  2. Application
  3. Adapters, API, UI, workers, persistence, or other edges
- A `Refactor Step`:
  - Starts from green tests.
  - Preserves existing behavior.
  - Keeps the build green throughout.
  - Does not introduce new externally visible behavior.
- A `Feature Step`:
  - Is test-first.
  - Starts by adding or updating the smallest relevant failing test.
  - Then changes production behavior to make the test pass.
  - Then refactors only while tests are green.
- Keep each step small enough to be reviewed and committed independently.

### Ubiquitous Language Check
State whether this slice uses existing ubiquitous language cleanly or whether it creates an opportunity to clarify, add, rename, or retire terms in `@UBIQUITOUS_LANGUAGE.md`.

Include this section even if there are no changes needed.

### Mergeability Check
List what must be true before this slice can be reviewed and merged, including the relevant tests, build checks, documentation updates, ubiquitous language updates, or behavioral verification.

Additional guidance:
- Prefer business/domain language from `@UBIQUITOUS_LANGUAGE.md` over technical implementation language.
- Do not include detailed implementation instructions.
- Do not reference specific file names or paths in the plan, except for the explicit references to `@UBIQUITOUS_LANGUAGE.md` and `@docs/plans/`.
- Do not over-plan future slices; keep each slice independently valuable or clearly enabling.
- If the requested scope is ambiguous, state reasonable assumptions before the plan.
