# Rules for text search: prefer ripgrep over grep

Always prefer `ripgrep` (`rg`) over plain `grep`. It is faster, respects `.gitignore` by default, and has output-tuning flags that keep token usage low.

Search-tool priority:

1. In Elixir contexts, reach for `dexter` first (semantic/symbol search).
2. For structural or AST-aware searches in any language, use `ast-grep`.
3. For plain text or regex search, use `ripgrep`.

Claude Code's built-in Grep tool already runs on ripgrep under the hood, so use it for your own searches. When you run a shell command for the user's benefit (scripts, one-offs, piping, commit hooks), invoke `rg` directly rather than `grep`.

Reach for these token-saving flags before dumping raw matches:

- `-l` / `--files-with-matches` — print only file paths that contain a match.
- `-c` / `--count` — print per-file match counts instead of the matching lines.
- `-m NUM` / `--max-count=NUM` — cap matches per file; great for "does this exist" checks.
- `-M NUM` / `--max-columns=NUM` — skip long minified lines; pair with `--max-columns-preview` when you still want a hint.
- `-C` / `-A` / `-B` — only add context lines when you actually need them; keep the number small.
- `-o` / `--only-matching` — print just the matched substring, not the whole line.
- `-t TYPE` / `-g GLOB` — scope the search to a file type or glob instead of greppping the world.
- `-n` off (`-N`) when line numbers aren't useful to the caller.
- `--json` only when a downstream tool will parse it; it is noisier than the default output.

Default to the narrowest output mode that answers the question, and widen only if the first pass is insufficient.
