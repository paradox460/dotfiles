-- ============================================================================
-- Treesitter Plugin Configuration (main branch)
-- ============================================================================
-- Treesitter provides better syntax highlighting, code understanding, and
-- text objects through incremental parsing.
--
-- Uses the rewritten `main` branch API (the legacy `master`/module system is
-- archived and incompatible with Neovim 0.12). Parser-management commands
-- (:TSInstall, :TSUpdate, :TSUninstall, :TSInstallFromGrammar, :TSLog) are
-- provided by the plugin automatically because it is not lazy-loaded.
-- See: https://github.com/nvim-treesitter/nvim-treesitter

return {
  {
    "nvim-treesitter/nvim-treesitter",

    -- Track the rewritten main branch (master is frozen for Nvim <= 0.11).
    branch = "main",

    -- Must not be lazy-loaded (per official docs); also ensures the
    -- :TSInstall/:TSUpdate/... user commands are registered.
    lazy = false,

    -- Rebuild parsers with the new compiler on plugin update.
    build = ":TSUpdate",

    config = function()
      -- Parsers to ensure are installed.
      local ensure_installed = {
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

      -- Install only the parsers that are missing (install() runs async).
      local installed = require("nvim-treesitter.config").get_installed()
      local to_install = vim.iter(ensure_installed)
        :filter(function(lang)
          return not vim.tbl_contains(installed, lang)
        end)
        :totable()
      if #to_install > 0 then
        require("nvim-treesitter").install(to_install)
      end

      -- Enable treesitter highlighting (and, where a parser exists,
      -- experimental treesitter indentation) per buffer.
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function()
          if pcall(vim.treesitter.start) then
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}
