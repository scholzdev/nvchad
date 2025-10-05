--[[
=====================================================================
========================== AUTOCOMMANDS ===========================
=====================================================================
This file contains automatic commands that trigger on specific events.
Combines NvChad defaults with Kickstart-inspired autocommands.
=====================================================================
--]]

-- Load NvChad's default autocommands first
require "nvchad.autocmds"

-- =====================================================================
-- KICKSTART-INSPIRED AUTOCOMMANDS
-- =====================================================================

-- Highlight when yanking (copying) text
-- This provides visual feedback when you copy text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Enhanced filetype detection for better icons
-- Ensures proper recognition of configuration files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  desc = 'Enhanced filetype detection for config files',
  group = vim.api.nvim_create_augroup('enhanced-filetype', { clear = true }),
  pattern = {
    "lazy-lock.json",
    ".luarc.json",
    "*.toml",
    "init.lua",
  },
  callback = function()
    local filename = vim.fn.expand("%:t")
    if filename == "lazy-lock.json" then
      vim.bo.filetype = "json"
    elseif filename == ".luarc.json" then
      vim.bo.filetype = "jsonc"
    elseif filename:match("%.toml$") then
      vim.bo.filetype = "toml"
    elseif filename == "init.lua" then
      vim.bo.filetype = "lua"
    end
  end,
})

--[[
=====================================================================
ADDITIONAL AUTOCOMMAND IDEAS:
=====================================================================

You can add more autocommands here as needed:

-- Auto-format on save (if you want global formatting):
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    vim.lsp.buf.format()
  end,
})

-- Auto-save when focus is lost:
vim.api.nvim_create_autocmd("FocusLost", {
  pattern = "*",
  command = "wa"
})

-- Restore cursor position when opening files:
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 1 and mark[1] <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})
=====================================================================
--]]
