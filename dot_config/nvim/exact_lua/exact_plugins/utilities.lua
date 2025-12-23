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

  -- Firenvim: Neovim in browser text areas
  {
    "glacambre/firenvim",
    lazy = not vim.g.started_by_firenvim,
    build = "firenvim#install(0)",
    config = function()
      -- Configure Firenvim settings
      vim.g.firenvim_config = {
        globalSettings = {
          alt = "all",
        },
        localSettings = {
          [".*"] = {
            cmdline = "neovim",
            content = "text",
            priority = 0,
            selector = "textarea",
            takeover = "never", -- Don't automatically take over text areas
          },
        },
      }

      -- Only apply these settings when running in Firenvim
      if vim.g.started_by_firenvim then
        -- Set larger font for browser use
        vim.opt.guifont = "JetBrains Mono:h20"

        -- Smaller window
        vim.opt.lines = 30
        vim.opt.columns = 100

        -- Auto-save functionality with debouncing
        local dont_write = false
        local function my_write()
          dont_write = false
          vim.cmd('write')
        end

        local function delay_my_write()
          if dont_write then
            return
          end
          dont_write = true
          vim.fn.timer_start(10000, my_write) -- 10 second delay
        end

        -- Auto-save on text changes
        vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
          pattern = "*",
          callback = delay_my_write,
          nested = true,
        })

        -- Map Command+V to paste from system clipboard
        vim.keymap.set("i", "<D-v>", "<C-r>+", { noremap = true })
      end
    end,
  },
}
