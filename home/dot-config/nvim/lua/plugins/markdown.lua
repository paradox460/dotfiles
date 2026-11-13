-- ============================================================================
-- Markdown and Documentation Plugins
-- ============================================================================
-- Enhanced markdown editing and Pandoc support

return {
  -- vim-pandoc: Comprehensive Pandoc integration
  {
    "vim-pandoc/vim-pandoc",
    ft = { "markdown", "pandoc" },
    dependencies = {
      -- Pandoc syntax highlighting
      "vim-pandoc/vim-pandoc-syntax",
    },
    config = function()
      -- Disable folding by default (can be slow on large files)
      vim.g["pandoc#folding#enabled"] = 0

      -- Use Treesitter for syntax highlighting if available
      vim.g["pandoc#syntax#use_treesitter"] = 1

      -- Disable spell checking (let user enable manually)
      vim.g["pandoc#spell#enabled"] = 0
    end,
  },

  -- vim-table-mode: Automatic table formatting for markdown
  {
    "dhruvasagar/vim-table-mode",
    cmd = { "TableModeToggle", "TableModeEnable", "TableModeRealign" },
    ft = { "markdown", "text", "pandoc" },
    keys = {
      { "<leader>tm", "<cmd>TableModeToggle<cr>", desc = "Toggle table mode" },
    },
    config = function()
      -- Use | as corner character for markdown-style tables
      vim.g.table_mode_corner = "|"

      -- Auto-format tables as you type
      vim.g.table_mode_auto_align = 1
    end,
  },

  -- tabular: Text alignment plugin (dependency for some markdown features)
  {
    "godlygeek/tabular",
    cmd = "Tabularize",
    keys = {
      { "<leader>a=", "<cmd>Tabularize /=<cr>", desc = "Align on =" },
      { "<leader>a:", "<cmd>Tabularize /:<cr>", desc = "Align on :" },
      { "<leader>a|", "<cmd>Tabularize /|<cr>", desc = "Align on |" },
      { "<leader>a=", "<cmd>Tabularize /=<cr>", mode = "x", desc = "Align on =" },
      { "<leader>a:", "<cmd>Tabularize /:<cr>", mode = "x", desc = "Align on :" },
      { "<leader>a|", "<cmd>Tabularize /|<cr>", mode = "x", desc = "Align on |" },
    },
  },
}
