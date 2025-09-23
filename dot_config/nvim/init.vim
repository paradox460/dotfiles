set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "elixir", "fish", "javascript", "json", "markdown" },

  sync_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  }
}
EOF
