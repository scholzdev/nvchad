--[[
=====================================================================
======================== LSP CONFIGURATION =========================
=====================================================================
Language Server Protocol (LSP) configuration.
Uses the new vim.lsp.config API for Neovim 0.11+ with fallback to
the traditional lspconfig for older versions.

Features:
- Auto-detection of new vs old API
- Integration with blink.cmp for completion
- Preconfigured servers: lua_ls, pyright, ruff, rust_analyzer
- Mason integration for automatic installation
=====================================================================
--]]

-- Get NvChad's LSP defaults
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

-- =====================================================================
-- COMPLETION INTEGRATION
-- =====================================================================

-- Enhance capabilities with blink.cmp if available
local has_blink, blink = pcall(require, "blink.cmp")
if has_blink then
  capabilities = vim.tbl_deep_extend("force", capabilities, blink.get_lsp_capabilities())
end

-- =====================================================================
-- LSP SERVER CONFIGURATION (Neovim 0.11+ API)
-- =====================================================================

-- Default configuration applied to all servers
local default_config = {
  on_attach = on_attach,     -- NvChad's default LSP keybindings
  on_init = on_init,         -- Initialization callback
  capabilities = capabilities, -- Enhanced with completion capabilities
}

  -- ===================================================================
  -- LUA LANGUAGE SERVER
  -- ===================================================================
  vim.lsp.config.lua_ls = vim.tbl_deep_extend('force', default_config, {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" }, -- Recognize 'vim' as global (for Neovim config)
        },
        completion = {
          callSnippet = "Replace", -- Better snippet completion
        },
        workspace = {
          library = {
            -- Add Neovim runtime and plugin paths for better completion
            vim.fn.expand "$VIMRUNTIME/lua",
            vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
            vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
          },
          maxPreload = 100000,      -- Load more files for better analysis
          preloadFileSize = 10000,  -- Larger files for analysis
        },
      },
    },
  })

  -- ===================================================================
  -- PYTHON LANGUAGE SERVERS
  -- ===================================================================
  -- Pyright: Type checking and intelligent features
  vim.lsp.config.pyright = default_config

  -- Ruff: Fast linting and formatting
  vim.lsp.config.ruff = default_config

  -- ===================================================================
  -- RUST LANGUAGE SERVER
  -- ===================================================================
  vim.lsp.config.rust_analyzer = vim.tbl_deep_extend('force', default_config, {
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy", -- Use clippy for better lints
        },
      },
    },
  })

  -- ===================================================================
  -- GO LANGUAGE SERVER
  -- ===================================================================
  vim.lsp.config.gopls = vim.tbl_deep_extend('force', default_config, {
    settings = {
      gopls = {
        gofumpt = true,              -- Use gofumpt for formatting
        codelenses = {
          gc_details = false,
          generate = true,
          regenerate_cgo = true,
          run_govulncheck = true,
          test = true,
          tidy = true,
          upgrade_dependency = true,
          vendor = true,
        },
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        analyses = {
          -- fieldalignment = true, -- Removed in gopls v0.17.0
          nilness = true,
          unusedparams = true,
          unusedwrite = true,
          useany = true,
          shadow = true,          -- Check for variable shadowing
          simplifycompositelit = true, -- Simplify composite literals
          unreachable = true,     -- Check for unreachable code
          undeclaredname = true,  -- Check for undeclared names
          fillreturns = true,     -- Fill in return values
        },
        usePlaceholders = true,
        completeUnimported = true,
        staticcheck = true,
        directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
        semanticTokens = true,
      },
    },
  })

-- ===================================================================
-- MASON INTEGRATION
-- ===================================================================
local has_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
if has_mason_lspconfig then
  mason_lspconfig.setup {
    ensure_installed = { "lua_ls", "pyright", "ruff", "rust_analyzer", "gopls" },
    automatic_installation = true, -- Auto-install missing servers
    handlers = {
      -- Default handler for servers not explicitly configured above
      function(server_name)
        if not vim.lsp.config[server_name] then
          vim.lsp.config[server_name] = default_config
        end
      end,
    },
  }
end

-- ============================================================================
-- DIAGNOSTIC CONFIGURATION
-- ============================================================================
-- Configure how LSP diagnostics (errors, warnings, hints) are displayed

vim.diagnostic.config {
  -- Sort diagnostics by severity (errors first)
  severity_sort = true,

  -- Floating window configuration for diagnostic details
  float = {
    border = "rounded",
    source = "if_many"  -- Show source only when multiple sources exist
  },

  -- Only underline errors (not warnings/hints) to reduce visual noise
  underline = { severity = vim.diagnostic.severity.ERROR },

  -- Custom icons for different diagnostic severities
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",  -- Red error icon
      [vim.diagnostic.severity.WARN] = "󰀪 ",   -- Yellow warning icon
      [vim.diagnostic.severity.INFO] = "󰋽 ",   -- Blue info icon
      [vim.diagnostic.severity.HINT] = "󰌶 ",   -- Green hint icon
    },
  },

  -- Virtual text configuration (inline diagnostic messages)
  virtual_text = {
    source = "if_many",  -- Show source when multiple exist
    spacing = 2,         -- Space between code and diagnostic text
    format = function(diagnostic)
      return diagnostic.message
    end,
  },
}