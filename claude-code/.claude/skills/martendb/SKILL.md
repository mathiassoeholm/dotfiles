---
name: martendb
description: Use when working with MartenDB document storage, schema migrations, LINQ queries, indexes, or performance optimization in .NET projects
---

# MartenDB Expert

> **MANDATORY: All MartenDB questions MUST be delegated to a subagent.**
>
> Use Task tool with `subagent_type: "general"`. Never answer MartenDB questions directly.
> The documentation is ~900KB and must be fetched fresh. Subagent isolation keeps your context clean.
> **No exceptions.**

## When to Use

- Writing or debugging Marten LINQ queries
- Configuring document storage (indexes, computed fields, foreign keys)
- Schema migrations and database management
- Performance optimization (batching, caching, query tuning)
- DAO implementations in Infrastructure layer
- Troubleshooting Marten-related errors

## Dispatching Subagents

When delegating MartenDB questions, use this prompt template:

```
You are a MartenDB expert. Answer the following question:

[USER'S QUESTION HERE]

**Instructions:**
1. Fetch the official MartenDB documentation:
   WebFetch: https://martendb.io/llms-full.txt

2. Search the fetched content for relevant sections

3. Provide guidance with code examples

**MBM Project Context:**
- DAO interfaces go in `src/MBM.Domain/` or `src/MBM.Application/`
- DAO implementations go in `src/MBM.Infrastructure/`
- Document types are suffixed with `Doc` (e.g., `ModelDesignDoc`)
- Use async methods (`StoreAsync`, `QueryAsync`)
- Follow Clean Architecture: Domain/Application never reference Infrastructure

**Report back:** Provide a clear answer with code examples adapted to MBM conventions.
```

## Quick Reference (for subagent)

| Operation      | Pattern                                                 |
| -------------- | ------------------------------------------------------- |
| Store document | `session.Store(doc); await session.SaveChangesAsync();` |
| Query by ID    | `await session.LoadAsync<T>(id)`                        |
| LINQ query     | `await session.Query<T>().Where(...).ToListAsync()`     |
| Batch load     | `await session.LoadManyAsync<T>(ids)`                   |
| Raw SQL        | `session.Query<T>("where data->>'field' = ?", value)`   |

## Common Mistakes

1. **Forgetting SaveChangesAsync** - Store/Update don't persist until SaveChanges
2. **N+1 queries** - Use `Include()` or batch loading instead of loops
3. **Missing indexes** - Add indexes for frequently queried fields
4. **Schema drift** - Run migrations in dev before deploying

## Documentation Sections

When fetching docs, key sections to search for:

- `/documents/` - Document storage basics
- `/documents/querying/` - LINQ and SQL queries
- `/documents/indexing/` - Index configuration
- `/schema/` - Schema management and migrations
- `/configuration/` - Store configuration options

## Rationalization Table

| Excuse                             | Reality                                                                                        |
| ---------------------------------- | ---------------------------------------------------------------------------------------------- |
| "I already know Marten basics"     | Marten has 900KB of docs with nuanced behaviors. Memory errors are guaranteed. Fetch the docs. |
| "This is a simple query question"  | Simple questions often have non-obvious gotchas. Subagent + docs takes 30 seconds.             |
| "I'll just answer from context"    | Your context doesn't have the docs. The subagent fetches them fresh.                           |
| "Subagent overhead is unnecessary" | Subagent launch is seconds; 900KB in your context is permanent pollution.                      |

**All of these mean: Delegate to subagent. No exceptions.**
