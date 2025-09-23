# Paths

fish_add_path -P $HOME/.bin $HOME/.cargo/bin

# Set Editors
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx PAGER "less -FRX"

# Elixir Options

set -gx ERL_AFLAGS "-kernel shell_history enabled"
set -gx KERL_BUILD_DOCS yes

# ripgrep config
set -gx RIPGREP_CONFIG_PATH $HOME/.ripgreprc

set -gx ATUIN_NOBIND "true"

if status is-interactive
  set -g fish_key_bindings fish_vi_key_bindings
  # atuin (synced history) config
  if command -q atuin
    atuin init fish | source
  end

  # fzf.fish config
  if command -q fzf && type -q fzf_configure_bindings
  end

  set fish_greeting (date)


  fzf_configure_bindings --directory=\ct --history=
end

# Direnv loads need to happen _after_ path is set
test -e /usr/local/bin/direnv ; or test -e /opt/homebrew/bin/direnv ; and eval (direnv hook fish)

zoxide init fish | source

# Atuin bindings
bind \cr _atuin_search
bind -M insert \cr _atuin_search
