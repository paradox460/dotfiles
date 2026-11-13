-- ============================================================================
-- Colorscheme Plugin Configuration
-- ============================================================================
-- Base16 colorscheme with Tomorrow Night theme

return {
  -- Base16/Tinted colorscheme plugin (updated repository)
  {
    "tinted-theming/base16-vim",
    lazy = false,
    priority = 1000,
    config = function()
      -- Enable true color support
      vim.opt.termguicolors = true

      -- Set the colorscheme to base16-tomorrow-night
      vim.cmd.colorscheme("base16-tomorrow-night")
    end,
  },
}
