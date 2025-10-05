--[[
=====================================================================
========================== VIM OPTIONS ============================
=====================================================================
This file contains all Vim options and settings.
Combines NvChad defaults with Kickstart improvements.
=====================================================================
--]]

-- Load NvChad's default options first
require "nvchad.options"

local opt = vim.opt

-- =====================================================================
-- KICKSTART-INSPIRED OPTIONS
-- =====================================================================

-- Confirmation dialogs instead of failing commands
opt.confirm = true

-- Scroll padding - keep cursor away from edges
opt.scrolloff = 8

-- Highlight the current line
opt.cursorline = true

-- =====================================================================
-- ADDITIONAL NEOVIM OPTIONS (from Kickstart)
-- =====================================================================

-- Show line numbers
opt.number = true
-- opt.relativenumber = true  -- Uncomment for relative line numbers

-- Enable mouse support in all modes
opt.mouse = 'a'

-- Don't show mode in command line (statusline shows it)
opt.showmode = false

-- Better line wrapping
opt.breakindent = true

-- Persistent undo history
opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital letters in search
opt.ignorecase = true
opt.smartcase = true

-- Always show sign column (for git, lsp, etc.)
opt.signcolumn = 'yes'

-- Faster completion and better experience
opt.updatetime = 250

-- Faster key sequence timeout
opt.timeoutlen = 300

-- Better window splitting
opt.splitright = true
opt.splitbelow = true

-- Show whitespace characters
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Live preview of substitutions
opt.inccommand = 'split'

-- =====================================================================
-- GLOBAL VARIABLES
-- =====================================================================

-- Disable netrw (we're using neo-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Disable any potential nvim-tree auto-start
vim.g.nvim_tree_disable_netrw = 0
vim.g.nvim_tree_hijack_netrw = 0

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

-- =====================================================================
-- CLIPBOARD SYNC (from Kickstart)
-- =====================================================================

-- Sync clipboard between OS and Neovim (scheduled for better startup time)
vim.schedule(function()
  opt.clipboard = 'unnamedplus'
end)
