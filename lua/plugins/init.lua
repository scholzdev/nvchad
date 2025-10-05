-- ============================================================================
-- NVCHAD CORE PLUGINS CONFIGURATION
-- ============================================================================
-- This file contains NvChad-specific plugin configurations and overrides
-- Custom plugins are located in lua/custom/plugins/

-- ============================================================================
-- NVCHAD CORE PLUGINS CONFIGURATION
-- ============================================================================
-- This file contains NvChad-specific plugin configurations and overrides
-- Custom plugins are located in lua/custom/plugins/

local plugins = {
  -- Override default configs
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "nvchad.configs.lspconfig"
      require "configs.lspconfig"
    end,
  },

  -- Mason for LSP installation
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- LSP servers
        "lua-language-server",
        "pyright",
        "ruff",
        "rust-analyzer",
        "gopls", -- Go LSP server

        -- Formatters
        "stylua",
        "isort",
        "black",
        "gofumpt", -- Go formatter (better than gofmt)
        "goimports", -- Go imports organizer

        -- Linters
        "markdownlint",
        "golangci-lint", -- Go linter

        -- Debug adapters
        "delve", -- Go debugger
      },
    },
  },

  -- Mason LSP Config for automatic server setup
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = { "lua_ls", "pyright", "ruff", "rust_analyzer", "gopls" },
      automatic_installation = true,
    },
  },

  -- Treesitter with additional languages
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "html",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "query",
        "vim",
        "vimdoc",
        "python",
        "rust",
        "go", -- Go syntax highlighting
        "gomod", -- go.mod files
        "gowork", -- go.work files
      },
      auto_install = true,
    },
  },

  -- Conform for formatting
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        go = { "goimports", "gofumpt" }, -- Format Go files
      },
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_fallback = true,
          }
        end
      end,
    },
  },
}

return plugins

