--[[
=====================================================================
========================== KEY MAPPINGS ===========================
=====================================================================
This file contains all custom key mappings and shortcuts.
Combines NvChad defaults with Kickstart-inspired keybindings.

Leader key is <Space> - set in init.lua
=====================================================================
--]]

-- Load NvChad's default key mappings first
require "nvchad.mappings"

local map = vim.keymap.set

-- =====================================================================
-- BASIC NAVIGATION & EDITING
-- =====================================================================

-- Ensure Esc always works in insert mode
map("i", "<Esc>", "<Esc>", { desc = "Exit insert mode" })

-- Additional escape alternatives (just in case)
map("i", "jk", "<Esc>", { desc = "Exit insert mode (alternative)" })

-- =====================================================================
-- OVERRIDE NVCHAD DEFAULTS (prevent conflicts)
-- =====================================================================

-- Disable any nvim-tree mappings from NvChad (we use Neo-tree)
vim.keymap.del("n", "<C-n>", { silent = true })
pcall(vim.keymap.del, "n", "<leader>e", { silent = true })

-- =====================================================================
-- GENERAL MAPPINGS (from Kickstart)
-- =====================================================================

-- Clear search highlights with Escape
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear highlights" })

-- Open diagnostic quickfix list
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic quickfix list" })

-- Exit terminal mode more easily
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- =====================================================================
-- FILE EXPLORER (Neo-tree)
-- =====================================================================

-- Toggle Neo-tree file explorer
map("n", "<C-n>", "<cmd>Neotree toggle<cr>", { desc = "Toggle Neo-tree" })
map("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle NeoTree" })

-- =====================================================================
-- FORMATTING (Conform.nvim)
-- =====================================================================

-- Format current buffer
map("n", "<leader>fm", function()
  require("conform").format { async = true, lsp_fallback = true }
end, { desc = "Format buffer" })

-- =====================================================================
-- TELESCOPE SEARCH (extending NvChad's defaults)
-- =====================================================================

-- Search help documentation
map("n", "<leader>sh", "<cmd>Telescope help_tags<cr>", { desc = "Search help" })

-- Search key mappings
map("n", "<leader>sk", "<cmd>Telescope keymaps<cr>", { desc = "Search keymaps" })

-- Find files in current directory
map("n", "<leader>sf", "<cmd>Telescope find_files<cr>", { desc = "Search files" })

-- Browse all Telescope pickers
map("n", "<leader>ss", "<cmd>Telescope builtin<cr>", { desc = "Search select telescope" })

-- Search for word under cursor
map("n", "<leader>sw", "<cmd>Telescope grep_string<cr>", { desc = "Search current word" })

-- Live grep search in all files
map("n", "<leader>sg", "<cmd>Telescope live_grep<cr>", { desc = "Search by grep" })

-- Search diagnostics (errors, warnings)
map("n", "<leader>sd", "<cmd>Telescope diagnostics<cr>", { desc = "Search diagnostics" })
-- Resume last search
map("n", "<leader>sr", "<cmd>Telescope resume<cr>", { desc = "Search resume" })

-- Theme switcher
map("n", "<leader>th", "<cmd>Telescope themes<cr>", { desc = "Change theme" })

-- Search recently opened files
map("n", "<leader>s.", "<cmd>Telescope oldfiles<cr>", { desc = "Search recent files" })

-- Find and switch between open buffers
map("n", "<leader><leader>", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })

-- =====================================================================
-- ADVANCED TELESCOPE SEARCHES
-- =====================================================================

-- Fuzzy search within current buffer
map("n", "<leader>/", function()
  require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = "Fuzzily search in current buffer" })

-- Search text in currently open files only
map("n", "<leader>s/", function()
  require("telescope.builtin").live_grep {
    grep_open_files = true,
    prompt_title = "Live Grep in Open Files",
  }
end, { desc = "Search in open files" })

-- Search files in Neovim configuration directory
map("n", "<leader>sn", function()
  require("telescope.builtin").find_files { cwd = vim.fn.stdpath "config" }
end, { desc = "Search Neovim files" })

-- =====================================================================
-- LSP MAPPINGS (Language Server Protocol)
-- =====================================================================
-- Note: Most basic LSP mappings are already set by NvChad
-- These are additional Kickstart-inspired LSP keybindings

-- Function to setup LSP keymaps when LSP attaches to a buffer
local function setup_lsp_keymaps(bufnr)
  local map = function(keys, func, desc, mode)
    mode = mode or 'n'
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
  end

  -- Rename the variable/function under cursor
  map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

  -- Execute a code action (quick fixes, refactoring)
  map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

  -- Find all references to symbol under cursor
  map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

  -- Jump to implementation of interface/abstract method
  map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

  -- Jump to definition of symbol under cursor
  map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

  -- Jump to declaration (e.g., header file in C)
  map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

  -- Show all symbols in current document
  map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

  -- Search symbols across entire workspace
  map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- Toggle inlay hints (type information inline)
  if vim.lsp.inlay_hint then
    map('<leader>th', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr })
    end, '[T]oggle Inlay [H]ints')
  end
end

-- =====================================================================
-- LSP AUTOCOMMANDS (automatic setup)
-- =====================================================================

-- Setup LSP keymaps when LSP attaches to a buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    -- Setup all the LSP keymaps for this buffer
    setup_lsp_keymaps(event.buf)

    -- Auto-highlight references of symbol under cursor
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
      local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })

      -- Highlight references when cursor is idle
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      -- Clear highlights when cursor moves
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      -- Clean up when LSP detaches
      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
        end,
      })
    end
  end,
})

--[[
=====================================================================
ADDITIONAL KEYBINDING NOTES:
=====================================================================

Window Navigation (from NvChad):
- <C-h/j/k/l> - Move between windows
- <C-w>s - Split horizontal
- <C-w>v - Split vertical

NvChad Default Mappings:
- <leader>ch - Open cheatsheet
- <leader>th - Change theme
- <Tab> - Next buffer
- <S-Tab> - Previous buffer

Git Mappings (GitSigns - see plugins/init.lua):
- ]c / [c - Next/previous git change
- <leader>hs - Stage hunk
- <leader>hr - Reset hunk
- <leader>hp - Preview hunk

Debug Mappings (DAP - see plugins/init.lua):
- <F5> - Start/Continue debug
- <F1/F2/F3> - Step into/over/out
- <leader>b - Toggle breakpoint

See :help which-key for real-time keymap discovery!
=====================================================================
--]]
-- You can add custom ones here if needed

-- Neo-tree
map("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle NeoTree" })
