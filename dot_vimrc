set nocompatible              " be iMproved, required

" set shell=bash " Lots of plugins choke on fish shell
try
  source ~/.vim/config/plugins.vim
  source ~/.vim/config/coc-vim-configs.vim
catch
endtry

set termguicolors
colorscheme base16-tomorrow-night

set backspace=2    " more powerful backspacing

" Fix some indent shit
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
filetype plugin indent on " per-filetype indent options

" Highlighting on (durr)
syntax enable

" Line numbers
set relativenumber number

" Show command
set showcmd

" Search enhancements
set hlsearch " enable highlight search queries
set incsearch " highlight search as you type

" Hidden buffer support
set hidden

" Word wrap
set wrap
set linebreak

" fzf
set rtp+=/usr/local/opt/fzf

" Statusline
set laststatus=2
set statusline=[%n]\ %f%(\ %r%)\%m\ %y%=%4l:%02v/%L\ %3p%%

" EasyMotion
let g:EasyMotion_smartcase = 1
let g:EasyMotion_keys='qwertzxcvbgasdf'

" Asterisk
let g:asterisk#keeppos = 1

" Tables
let g:table_mode_corner='|'

" NERDCommenter
let g:NERDSpaceDelims = 1
let g:NERDTrimTrailingWhitespace = 1

" Customize AutoAave
let g:auto_save_events = ["InsertLeave", "TextChanged", "CursorHoldI"]

" Better leader
nnoremap <Space> <Nop>
let mapleader = "\<Space>"
let maplocalleader=","

" Load custom keybinds
try
  source ~/.vim/config/keybinds.vim
catch
endtry

" Settings for FireNvim
let g:firenvim_config = {
  \ 'localSettings': {
    \ '.*': {
      \ 'takeover': 'never'
    \ }
  \ }
\ }

let g:dont_write = v:false
function! My_Write(timer) abort
  let g:dont_write = v:false
  write
endfunction

function! Delay_My_Write() abort
   if g:dont_write
    return
  end
  let g:dont_write = v:true
  call timer_start(10000, 'My_Write')
endfunction


function! s:IsFirenvimActive(event) abort
  if !exists('*nvim_get_chan_info')
    return 0
  endif
  let l:ui = nvim_get_chan_info(a:event.chan)
  return has_key(l:ui, 'client') && has_key(l:ui.client, 'name') &&
      \ l:ui.client.name =~? 'Firenvim'
endfunction

function! OnUIEnter(event) abort
  if s:IsFirenvimActive(a:event)
    set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
    set guifont=JetBrains\ Mono:h20
    au TextChanged * ++nested call Delay_My_Write()
    au TextChangedI * ++nested call Delay_My_Write()
    inoremap <D-v> <c-r>+
  endif
endfunction
autocmd UIEnter * call OnUIEnter(deepcopy(v:event))
