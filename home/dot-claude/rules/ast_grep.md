# Rules for searching structured code with ast-grep

Prefer `ast-grep` over plain text search (ripgrep/grep) whenever you're looking for a structured code pattern — function definitions, call sites, specific argument shapes, imports, class declarations, AST-level constructs. Ripgrep still wins for free-text, log lines, comments, and when you truly just want a literal string.

Priority order:
1. In Elixir contexts, `dexter` takes priority over everything else.
2. Outside Elixir (or when dexter doesn't apply), `ast-grep` is preferred over ripgrep for structural searches.
3. Fall back to `rg` for plain-text searches.

Meta-variables in patterns: `$VAR` matches a single node, `$$$ARGS` matches a list of nodes (useful for argument lists, bodies, etc.).

Common invocations:

```bash
# Search with a pattern (language auto-detected from files)
ast-grep -p 'console.log($MSG)'

# Force a language when files are ambiguous or you're piping via stdin
ast-grep -p 'def $NAME($$$ARGS)' -l python

# Scope to specific paths
ast-grep -p 'useEffect($$$ARGS)' src/

# Find all call sites of a function
ast-grep -p 'myFunc($$$)' -l typescript

# Match a class definition by name
ast-grep -p 'class $NAME extends React.Component { $$$ }' -l tsx

# Rewrite in place (preview without --update-all)
ast-grep -p '$A && $A()' -r '$A?.()' -l javascript

# Restrict files with globs
ast-grep -p 'fn $NAME($$$) { $$$ }' -l rust --globs 'src/**/*.rs'

# Debug a pattern that isn't matching
ast-grep -p 'foo($X)' -l python --debug-query=ast
```

Tips:
- If a pattern doesn't match anything, run it again with `--debug-query=ast` to inspect how ast-grep parsed it.
- Use `--strictness relaxed` or `template` when comment noise or minor node differences are causing false negatives.
- For complex rules (multiple conditions, constraints), use YAML rules via `ast-grep scan` instead of inline `-p` patterns.
