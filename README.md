# Dotfiles

These are my dotfiles. They are managed with [mise's dotfiles support](https://mise.jdx.dev/dotfiles.html). Everything under `home/` is linked into `~` (`dot-` names become `.` names); `*.tera` files are rendered as templates. The declaration lives in `home/dot-config/mise/conf.d/dotfiles.toml`.

## Setup/Installation

```sh
git clone https://github.com/paradox460/dotfiles.git ~/.dotfiles
mkdir -p ~/.config/mise/conf.d
ln -s ~/.dotfiles/home/dot-config/mise/conf.d/dotfiles.toml ~/.config/mise/conf.d/dotfiles.toml
mise run setup --only repos,dotfiles
```

`setup` is `mise bootstrap --prompt-vars` run under `fnox exec`; it installs fnox for itself, asks for your git name, email, and signing key once, then clones the mpv script repos and deploys everything. Drop `--only` to run the full bootstrap (packages, macOS defaults, tools).

The GitHub MCP token in the Claude and Zed settings comes from the macOS keychain through fnox (`scripts/fnox.toml`, keychain service `github`, account `mcp`). That config lives outside `home/` on purpose: deployed as `~/.config/fnox/config.toml` it would be fnox's global config, and the `fnox activate` hook would export the token into every shell. Only the `dot` and `setup` tasks load it, with `fnox -c`. mise writes the token only when the key is missing from the live file, so on a machine without the keychain item it's written empty. To fill it in (or rotate it), store the token, delete the key from both settings files (`env.GITHUB_MCP_PAT` in `~/.claude/settings.json`, `context_servers.mcp-server-github.settings.github_personal_access_token` in `~/.config/zed/settings.json`), then apply:

```sh
fnox -c ~/.dotfiles/scripts/fnox.toml set GITHUB_MCP_PAT --provider github-keychain --key-name mcp   # paste the token at the hidden prompt
mise run dot apply
```

Work machines: put work-only git config in `~/.gitconfig.work`; `~/.gitconfig` includes it when present.

## Making changes

Most files in `~` are symlinks into `home/`, so editing them in place (`~/.config/fish/config.fish`, `~/.bin/jjx`, …) edits the repo directly. Nothing needs to be applied or copied back.

Templates (`*.tera`) are the exception: `~/.gitconfig`, `~/.config/jj/conf.d/local.toml`, the darwin-only `~/.bin` scripts, and friends are rendered copies. Edit the source, then re-render:

```sh
mise run dot edit --apply ~/.gitconfig   # opens home/dot-gitconfig.tera, applies on exit
```

Claude Code and Zed rewrite their own settings, so mise manages only some of their keys and leaves the rest to the app:

| Source (under `home/`) | Keys | On apply |
| --- | --- | --- |
| `dot-claude/settings.json`, `dot-config/zed/settings.json` | the ones you care about (Claude: `hooks`, `permissions`; Zed: editor, vim, theme, fonts, languages, panels) | reset to the repo's value |
| `dot-claude/settings.defaults.json`, `dot-config/zed/settings.defaults.json` | seeded defaults (Claude `model`; Zed AI/agent settings, context servers, SSH hosts) | written only when the key is missing; the app owns it after that |
| `*.token.json.tera` | the GitHub token | written only when the key is missing |

To enforce a setting, add it to the first file; to stop enforcing one, move it to the defaults file or delete it (mise never removes keys from the live file). `mise dot status` and `diff` only compare the keys in these files, so keys the app adds never show up as drift.

Start managing a new file (it lands in `home/` under its `dot-` name and is replaced with a link):

```sh
mise dot add ~/.config/foo/config.toml
```

A file created directly in `home/` (e.g. a new `home/dot-config/mise/conf.d/*.toml`) isn't linked until the next `mise run dot apply`. Group files can't be applied by target path; run the full apply.

To stop managing a file, delete it from `home/` and run `mise run dot apply --prune`, which removes the dangling link.

Check that the machine matches the repo:

```sh
mise run dot status --missing
```

`mise run dot <mise dot args>` wraps `mise dot` in `fnox exec`. It's only required when mise has to write the token (new machine, rotation); otherwise a plain `mise dot apply`/`diff`/`status` works. The `cz` fish abbreviation expands to `mise run dot`, so `cz apply`, `cz diff`, and `cz status` work too.

## Syncing with GitHub

The repo is a colocated jj/git repository with `main` tracking `origin/main`.

Push local changes:

```sh
cd ~/.dotfiles
jj describe -m "What changed"
jj bookmark set main -r @
jj git push
jj new
```

Pull changes made on another machine and deploy them:

```sh
cd ~/.dotfiles
jj git fetch
jj rebase -d main@origin
mise run dot apply --prune
```

`apply` relinks, re-renders changed templates, removes links whose source was deleted, and runs the post-dotfiles hook (usage completions, bun completions, and `fisher update` when `fish_plugins` changed). With plain git it's `git pull --rebase` followed by the same apply.

The mpv script repos under `~/.config/mpv/script_sources` are not updated by `apply`; fast-forward them with:

```sh
mise bootstrap --only repos --update --yes
```

## Older version

An older, manually managed version of my dotfiles exists in the `master` branch. It exists only for archival purposes
