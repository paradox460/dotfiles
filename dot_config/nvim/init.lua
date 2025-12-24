-- ============================================================================
-- Basic Settings
-- ============================================================================

-- Enable more powerful backspacing (backspace over indent, eol, and start)
vim.opt.backspace = 'indent,eol,start'

-- ============================================================================
-- Indentation Settings
-- ============================================================================

-- Set tab width to 2 spaces
vim.opt.tabstop = 2

-- Disable softtabstop (use tabstop value)
vim.opt.softtabstop = 0

-- Convert tabs to spaces
vim.opt.expandtab = true

-- Set indent width to 2 spaces for << and >> operations
vim.opt.shiftwidth = 2

-- Enable smart tab behavior (respect shiftwidth at line start)
vim.opt.smarttab = true

-- Enable filetype detection, plugins, and indent rules
vim.cmd('filetype plugin indent on')

-- ============================================================================
-- Syntax and Highlighting
-- ============================================================================

-- Enable syntax highlighting
vim.cmd('syntax enable')

-- ============================================================================
-- Line Numbers
-- ============================================================================

-- Always show the number column
vim.opt.number = true

-- Show relative line numbers by default for easier navigation
vim.opt.relativenumber = true

-- Create autocommand group for line number switching
local line_number_group = vim.api.nvim_create_augroup('LineNumberToggle', { clear = true })

-- Switch to absolute line numbers in insert mode
vim.api.nvim_create_autocmd('InsertEnter', {
  group = line_number_group,
  pattern = '*',
  callback = function()
    vim.opt.relativenumber = false
  end,
  desc = 'Show absolute line numbers in insert mode'
})

-- Switch back to relative line numbers in normal mode
vim.api.nvim_create_autocmd('InsertLeave', {
  group = line_number_group,
  pattern = '*',
  callback = function()
    vim.opt.relativenumber = true
  end,
  desc = 'Show relative line numbers in normal mode'
})

-- ============================================================================
-- UI Settings
-- ============================================================================

-- Show partial commands in the last line of the screen
vim.opt.showcmd = true

-- ============================================================================
-- Search Settings
-- ============================================================================

-- Highlight search results
vim.opt.hlsearch = true

-- Show search matches as you type
vim.opt.incsearch = true

-- ============================================================================
-- Buffer Settings
-- ============================================================================

-- Allow switching buffers without saving changes
vim.opt.hidden = true

-- ============================================================================
-- Text Wrapping
-- ============================================================================

-- Enable line wrapping
vim.opt.wrap = true

-- Break lines at word boundaries instead of mid-word
vim.opt.linebreak = true

-- ============================================================================
-- Leader Key Configuration
-- ============================================================================

-- Unmap space key to prevent conflicts
vim.keymap.set('n', '<Space>', '<Nop>', { silent = true })

-- Set space as the leader key for custom mappings
vim.g.mapleader = ' '

-- Set comma as the local leader key for filetype-specific mappings
vim.g.maplocalleader = ','

-- ============================================================================
-- Status Line Configuration
-- ============================================================================

-- Always show the status line (2 = always)
vim.opt.laststatus = 2

-- Custom statusline format:
-- [buffer_number] filename (readonly_flag) modified_flag filetype = line:column/total_lines percentage
vim.opt.statusline = '[%n]\\ %f%(\\ %r%)%m\\ %y%=%4l:%02v/%L\\ %3p%%'

-- ============================================================================
-- Machine Local configuration
-- ===========================================================================

pcall(require, 'config.local')

-- ============================================================================
-- Plugin Management (lazy.nvim)
-- ===========================================================================
require("config.lazy")
