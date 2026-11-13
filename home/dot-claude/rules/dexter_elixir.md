# Rules for Elixir projects: use dexter

In Elixir projects, use `dexter` for symbol lookup and reference search instead of Grep, ripgrep, or ast-grep. Dexter is a purpose-built Elixir LSP that understands modules, functions, aliases, and `defdelegate` — it is substantially faster and more accurate than text search for Elixir code.

Use Grep/ripgrep only for non-code text (strings, comments, config values, docs) or when you need a raw pattern match across arbitrary files. For anything involving Elixir modules or functions, reach for dexter first.

## Core commands

Run `dexter init` once per project before using lookup/references. It builds the full index. Re-run with `--force` if the index seems stale.

```
dexter init                                # index the current project
dexter reindex <file>                      # re-index a single file after changes
dexter lookup MyApp.MyModule               # find where a module is defined
dexter lookup MyApp.MyModule my_function   # find where a function is defined
dexter references MyApp.MyModule           # find all references to a module
dexter references MyApp.MyModule my_func   # find all references to a function
```

## Useful flags

- `dexter lookup --strict` — exit 1 if no exact match (no fuzzy fallback); use when scripting.
- `dexter lookup --no-follow-delegates` — stop at the `defdelegate`, don't jump to the delegated target.
- `dexter init --force` — rebuild the index from scratch if results look wrong.

## Workflow tips

- Prefer `dexter lookup` over Grep when you know the module or function name — it resolves aliases, imports, and delegates correctly.
- Prefer `dexter references` over Grep when tracing callers — it won't give false positives from strings, comments, or unrelated modules that happen to share a name.
- After editing a file, run `dexter reindex <file>` so subsequent lookups reflect your changes.
- `dexter lsp` starts the LSP server on stdio; don't invoke it directly from the shell — it's for editor integration only.
