-- ============================================================================
-- Language-Specific Plugins
-- ============================================================================
-- Plugins for specific programming languages

return {
  -- Elixir language support
  {
    "elixir-editors/vim-elixir",
    ft = { "elixir", "eelixir", "heex" },
  },

  -- Fish shell script support
  {
    "dag/vim-fish",
    ft = "fish",
    config = function()
      -- Set Fish files to use 2-space indentation
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "fish",
        callback = function()
          vim.opt_local.tabstop = 2
          vim.opt_local.shiftwidth = 2
          vim.opt_local.expandtab = true
        end,
      })
    end,
  },
}
