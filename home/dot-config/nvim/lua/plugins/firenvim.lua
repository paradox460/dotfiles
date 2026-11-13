return {
  -- Firenvim: Neovim in browser text areas
  {
    "glacambre/firenvim",
    lazy = not vim.g.started_by_firenvim,
    build = ":call firenvim#install(0)",
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
  }
}
