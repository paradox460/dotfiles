-- ============================================================================
-- Treesitter Plugin Configuration (main branch)
-- ============================================================================
-- Treesitter provides better syntax highlighting, code understanding, and
-- text objects through incremental parsing
--
-- Note: This uses the NEW main branch API (not master/legacy)
-- See: https://github.com/nvim-treesitter/nvim-treesitter

return {
  -- Main Treesitter plugin
  {
    "nvim-treesitter/nvim-treesitter",
    
    -- IMPORTANT: Must not be lazy-loaded (per official docs)
    lazy = false,
    
    -- Automatically update parsers on plugin update
    build = ":TSUpdate",
    
    -- Plugin configuration
    config = function()
      -- List of languages to install parsers for
      local languages = {
        "elixir",
        "fish",
        "javascript",
        "json",
        "markdown",
        "markdown_inline",
        "lua",
        "vim",
        "vimdoc",
        "bash",
        "python",
        "html",
        "css",
        "typescript",
        "yaml",
        "toml",
      }
      
      -- Install parsers asynchronously (non-blocking)
      require("nvim-treesitter").install(languages)
      
      -- Enable treesitter highlighting for supported filetypes
      -- This replaces the old configs.setup({ highlight = { enable = true } })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function()
          -- Check if treesitter parser is available for this filetype
          local ok, parser = pcall(vim.treesitter.get_parser)
          if ok and parser then
            vim.treesitter.start()
          end
        end,
      })
      
      -- Optional: Enable treesitter-based indentation (experimental)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = languages,
        callback = function()
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}