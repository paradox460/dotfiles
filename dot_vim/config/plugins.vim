if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')
Plug 'tinted-theming/base16-vim'
Plug 'godlygeek/tabular'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug '907th/vim-auto-save'

"Textobjects
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-line'

Plug 'christoomey/vim-sort-motion' "Sort Motions
Plug 'haya14busa/vim-asterisk' " Better * search
Plug 'haya14busa/is.vim' " Incremental Switch enhancements
Plug 'google/vim-searchindex' " Show [1/3] for search
Plug 'vim-pandoc/vim-pandoc' " Pandoc for great justice. Also better markdown than anything else
Plug 'vim-pandoc/vim-pandoc-syntax' " Syntax Plug for pandoc styles
Plug 'dhruvasagar/vim-table-mode' " Markdown tables, made easier
Plug 'scrooloose/nerdcommenter' " Easier commenting
Plug 'vim-scripts/ReplaceWithRegister' " Replaces selection/textobj with register

Plug 'neoclide/coc.nvim', {'branch': 'release'} " Code Completion

Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } } " Firenvim, vim in browser

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'elixir-editors/vim-elixir'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'dag/vim-fish'

call plug#end()
