-- ============================================================================
-- Motion and Movement Plugins
-- ============================================================================
-- Plugins that enhance cursor movement and text manipulation

return {
  -- EasyMotion: Fast cursor movement with labeled jumps
  {
    "easymotion/vim-easymotion",
    keys = {
      { "<leader><leader>", desc = "EasyMotion prefix" },
      { "<leader><leader>w", "<Plug>(easymotion-w)", desc = "EasyMotion word forward" },
      { "<leader><leader>b", "<Plug>(easymotion-b)", desc = "EasyMotion word backward" },
      { "<leader><leader>f", "<Plug>(easymotion-f)", desc = "EasyMotion find char" },
      { "<leader><leader>s", "<Plug>(easymotion-s)", desc = "EasyMotion search char" },
      { "<leader><leader>j", "<Plug>(easymotion-j)", desc = "EasyMotion line down" },
      { "<leader><leader>k", "<Plug>(easymotion-k)", desc = "EasyMotion line up" },
    },
    config = function()
      -- Enable smart case (case-insensitive unless uppercase used)
      vim.g.EasyMotion_smartcase = 1
      
      -- Custom key sequence for target selection
      vim.g.EasyMotion_keys = "qwertzxcvbgasdf"
      
      -- Keep cursor column when moving vertically
      vim.g.EasyMotion_startofline = 0
    end,
  },

  -- vim-sort-motion: Sort text with motion commands
  {
    "christoomey/vim-sort-motion",
    keys = {
      { "gs", "<Plug>SortMotion", desc = "Sort motion" },
      { "gs", "<Plug>SortMotionVisual", mode = "x", desc = "Sort selection" },
      { "gss", "<Plug>SortLines", desc = "Sort lines" },
    },
  },
}
