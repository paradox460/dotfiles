-- ============================================================================
-- Utility Plugins
-- ============================================================================
-- General utility plugins for enhanced editing experience

return {
  -- vim-auto-save: Automatically save files on certain events
  {
    "907th/vim-auto-save",
    event = { "InsertLeave", "TextChanged" },
    config = function()
      -- Enable auto-save by default
      vim.g.auto_save = 1

      -- Define events that trigger auto-save
      vim.g.auto_save_events = { "InsertLeave", "TextChanged", "CursorHoldI" }

      -- Don't display save messages
      vim.g.auto_save_silent = 1

      -- Don't save while in insert mode
      vim.g.auto_save_in_insert_mode = 0
    end,
  },

  -- NERDCommenter: Easy commenting/uncommenting
  {
    "preservim/nerdcommenter",
    keys = {
      { "<leader>c<space>", "<Plug>NERDCommenterToggle", desc = "Toggle comment" },
      { "<leader>c<space>", "<Plug>NERDCommenterToggle", mode = "x", desc = "Toggle comment" },
      { "<leader>cc", "<Plug>NERDCommenterComment", desc = "Comment lines" },
      { "<leader>cc", "<Plug>NERDCommenterComment", mode = "x", desc = "Comment selection" },
      { "<leader>cu", "<Plug>NERDCommenterUncomment", desc = "Uncomment lines" },
      { "<leader>cu", "<Plug>NERDCommenterUncomment", mode = "x", desc = "Uncomment selection" },
      { "<leader>cy", "<Plug>NERDCommenterYank", desc = "Yank then comment" },
      { "<leader>cy", "<Plug>NERDCommenterYank", mode = "x", desc = "Yank then comment" },
    },
    config = function()
      -- Add space after comment delimiter
      vim.g.NERDSpaceDelims = 1

      -- Remove trailing whitespace when uncommenting
      vim.g.NERDTrimTrailingWhitespace = 1

      -- Enable NERDCommenter for empty lines
      vim.g.NERDCommentEmptyLines = 1

      -- Align line-wise comment delimiters
      vim.g.NERDDefaultAlign = "left"
    end,
  },
}
