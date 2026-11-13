-- ============================================================================
-- FZF Plugin Configuration
-- ============================================================================
-- FZF provides fuzzy finding for files, buffers, and text

return {
  -- FZF vim integration
  {
    "junegunn/fzf.vim",
    dependencies = {
      -- FZF binary (can also be installed via homebrew)
      {
        "junegunn/fzf",
        build = "./install --all",
      },
    },
    
    -- Load on command or keymap
    cmd = {
      "Files",
      "GFiles",
      "Buffers",
      "Colors",
      "Ag",
      "Rg",
      "Lines",
      "BLines",
      "Tags",
      "BTags",
      "Marks",
      "Windows",
      "History",
      "Snippets",
      "Commits",
      "BCommits",
      "Commands",
      "Maps",
      "Helptags",
    },
    
    keys = {
      { "<leader>ff", "<cmd>Files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>GFiles<cr>", desc = "Find git files" },
      { "<leader>fb", "<cmd>Buffers<cr>", desc = "Find buffers" },
      { "<leader>fl", "<cmd>Lines<cr>", desc = "Find lines" },
      { "<leader>fr", "<cmd>Rg<cr>", desc = "Find with ripgrep" },
      { "<leader>fh", "<cmd>History<cr>", desc = "Find file history" },
      { "<leader>fc", "<cmd>Commands<cr>", desc = "Find commands" },
    },
    
    -- Plugin configuration
    config = function()
      -- Set FZF layout options (floating window)
      vim.g.fzf_layout = { window = { width = 0.9, height = 0.6 } }
      
      -- Customize FZF colors to match Neovim colorscheme
      vim.g.fzf_colors = {
        fg = { "fg", "Normal" },
        bg = { "bg", "Normal" },
        hl = { "fg", "Comment" },
        ["fg+"] = { "fg", "CursorLine", "CursorColumn", "Normal" },
        ["bg+"] = { "bg", "CursorLine", "CursorColumn" },
        ["hl+"] = { "fg", "Statement" },
        info = { "fg", "PreProc" },
        border = { "fg", "Ignore" },
        prompt = { "fg", "Conditional" },
        pointer = { "fg", "Exception" },
        marker = { "fg", "Keyword" },
        spinner = { "fg", "Label" },
        header = { "fg", "Comment" },
      }
    end,
  },
}
