# UBIQUITOUS_LANGUAGE.md Format

`UBIQUITOUS_LANGUAGE.md` is MBM's single canonical glossary. It lives at the repository root.

## Structure

Use the repo's existing structure:

```md
# Ubiquitous Language

## {Domain area}

| Term | Definition | Aliases to avoid |
|------|------------|------------------|
| **ModelDesign** | A logical model design identified by a ModelDesignId, within which each ModelDesign Version is a specific snapshot | Model, design, MD |
| **ModelDesign Version** | A specific versioned snapshot of a ModelDesign identified by a ModelDesignId and Version | Version, model version, snapshot |

## Relationships

- A **ModelDesign** contains one or more **ModelDesign Versions**
- A **ModelDesign Version** contains one or more **BuildDesigns**

## Example dialogue

> **Dev:** "When we create a **SetDesign**, do we embed the **ModelDesign** data inside it?"
> **Domain expert:** "No. A **SetDesign** references **ModelDesigns** by ID."

## Flagged ambiguities

- **"ModelDesign"** is used ambiguously for both the version family and a specific `(ModelDesignId, Version)` snapshot. Use **ModelDesign Version** whenever you mean a specific versioned snapshot.
```

## Rules

- **Use one root file.** MBM uses exactly one `UBIQUITOUS_LANGUAGE.md`; do not introduce `CONTEXT.md`, `CONTEXT-MAP.md`, or per-context glossary files.
- **Be opinionated.** When multiple words exist for the same concept, pick the best canonical term and list the others as aliases to avoid.
- **Prefer existing MBM terms.** Before adding a term, search `UBIQUITOUS_LANGUAGE.md`, relevant KDRs, feature briefs, and code for existing names.
- **Flag conflicts explicitly.** If a term is used ambiguously, call it out in `Flagged ambiguities` with a clear resolution.
- **Keep definitions tight.** Prefer one sentence. Define what the concept is, not every operation involving it.
- **Keep implementation out unless it is part of the domain language.** `ModelDesign Version`, `BuildDesign`, and `Source Artifact` belong. General programming concepts, handler names, endpoint mechanics, and delivery tasks usually do not.
- **Group terms under subheadings.** Add to an existing domain area when possible; create a new `##` section only when the concept does not fit any existing area.
- **Use markdown table rows for terms.** Preserve the `Term | Definition | Aliases to avoid` table format.
- **Show relationships.** Add or update relationship bullets when a new term changes cardinality, ownership, or reference semantics.
- **Use example dialogue when it clarifies boundaries.** Add short domain-expert dialogue for confusing concepts or newly resolved ambiguities.

## Term row conventions

- Bold canonical terms: `**BuildDesign**`.
- Put aliases to avoid as comma-separated text, not code, unless the alias is literally code/API syntax.
- Prefer MBM's exact capitalization for domain terms.
- If an alias is acceptable only in a legacy context, say so in the definition or flagged ambiguity instead of silently accepting it.

## Before adding a term

Ask:

1. Is this a concept specific to MBM's product/domain, or just a general software/architecture term?
2. Is there already a canonical term in `UBIQUITOUS_LANGUAGE.md`?
3. Does the term define stable language, or is it a temporary implementation detail better suited to a KDR, Brief, Plan, Slice, or Step?
4. Does adding it require a relationship or ambiguity update?

Only add the term if it improves durable shared language.
