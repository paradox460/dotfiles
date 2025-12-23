-- ============================================================================
-- Search Enhancement Plugins
-- ============================================================================
-- Plugins that improve search functionality and visual feedback

return {
  -- vim-asterisk: Better * and # search (keeps cursor position)
  {
    "haya14busa/vim-asterisk",
    keys = {
      { "*", "<Plug>(asterisk-*)", desc = "Search word forward" },
      { "#", "<Plug>(asterisk-#)", desc = "Search word backward" },
      { "g*", "<Plug>(asterisk-g*)", desc = "Search word forward (partial)" },
      { "g#", "<Plug>(asterisk-g#)", desc = "Search word backward (partial)" },
      { "z*", "<Plug>(asterisk-z*)", desc = "Search word forward (stay)" },
      { "z#", "<Plug>(asterisk-z#)", desc = "Search word backward (stay)" },
    },
    config = function()
      -- Keep cursor position when searching with *
      vim.g["asterisk#keeppos"] = 1
    end,
  },

  -- is.vim: Incremental search improvements
  {
    "haya14busa/is.vim",
    event = "CmdlineEnter",
    config = function()
      -- Automatically clear search highlight after cursor movement
      vim.g["is#do_default_mappings"] = 1
    end,
  },

  -- vim-searchindex: Show [1/3] style match count for searches
  {
    "google/vim-searchindex",
    event = "CmdlineEnter",
  },
}
