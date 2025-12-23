-- ============================================================================
-- Git Integration Plugins
-- ============================================================================
-- Plugins for Git operations and visualization

return {
  -- vim-fugitive: Comprehensive Git wrapper
  {
    "tpope/vim-fugitive",
    cmd = {
      "Git",
      "Gstatus",
      "Gblame",
      "Gpush",
      "Gpull",
      "Gdiff",
      "Gwrite",
      "Gread",
      "Gcommit",
      "Glog",
    },
    keys = {
      { "<leader>gs", "<cmd>Git<cr>", desc = "Git status" },
      { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git blame" },
      { "<leader>gd", "<cmd>Gdiff<cr>", desc = "Git diff" },
      { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit" },
      { "<leader>gp", "<cmd>Git push<cr>", desc = "Git push" },
      { "<leader>gl", "<cmd>Git pull<cr>", desc = "Git pull" },
    },
  },

  -- vim-gitgutter: Show git diff in sign column
  {
    "airblade/vim-gitgutter",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      -- Update sign column faster (default is 4000ms)
      vim.opt.updatetime = 250
      
      -- Disable default key mappings (define custom ones)
      vim.g.gitgutter_map_keys = 0
      
      -- Custom signs for better visibility
      vim.g.gitgutter_sign_added = "+"
      vim.g.gitgutter_sign_modified = "~"
      vim.g.gitgutter_sign_removed = "-"
      vim.g.gitgutter_sign_removed_first_line = "‾"
      vim.g.gitgutter_sign_modified_removed = "~"
    end,
    keys = {
      { "]h", "<cmd>GitGutterNextHunk<cr>", desc = "Next git hunk" },
      { "[h", "<cmd>GitGutterPrevHunk<cr>", desc = "Previous git hunk" },
      { "<leader>hp", "<cmd>GitGutterPreviewHunk<cr>", desc = "Preview git hunk" },
      { "<leader>hs", "<cmd>GitGutterStageHunk<cr>", desc = "Stage git hunk" },
      { "<leader>hu", "<cmd>GitGutterUndoHunk<cr>", desc = "Undo git hunk" },
    },
  },
}
