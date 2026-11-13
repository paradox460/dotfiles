-- ============================================================================
-- Text Objects Plugins
-- ============================================================================
-- Enhanced text objects for more powerful text manipulation

return {
  -- Base plugin for creating custom text objects
  {
    "kana/vim-textobj-user",
    lazy = false,
    dependencies = {
      -- Text object for entire buffer (ae/ie)
      { "kana/vim-textobj-entire" },
      
      -- Text object for indentation levels (ai/ii/aI/iI)
      { "kana/vim-textobj-indent" },
      
      -- Text object for current line (al/il)
      { "kana/vim-textobj-line" },
    },
  },

  -- vim-surround: Easily add, change, delete surrounding pairs
  {
    "tpope/vim-surround",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      -- vim-repeat: Make plugin actions repeatable with .
      "tpope/vim-repeat",
    },
  },

  -- ReplaceWithRegister: Replace text objects with register content (gr motion)
  {
    "vim-scripts/ReplaceWithRegister",
    keys = {
      { "gr", desc = "Replace with register" },
      { "gr", mode = "x", desc = "Replace selection with register" },
    },
  },
}
