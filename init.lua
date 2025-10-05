--[[
=====================================================================
==================== NVCHAD + KICKSTART CONFIG ====================
=====================================================================
This configuration combines the best of NvChad and Kickstart.nvim:
- NvChad: Modern UI, stable base, great defaults
- Kickstart: Practical plugins, educational structure
- Custom: Your personal additions in lua/custom/
=====================================================================
--]]

-- Base46 theme cache location for NvChad themes
vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"

-- Set space as the leader key (must be before plugins load)
vim.g.mapleader = " "

-- Disable netrw (we use Neo-tree instead)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- Auto-install lazy.nvim if not present
if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

-- Add lazy.nvim to runtime path
vim.opt.rtp:prepend(lazypath)

-- Load lazy.nvim configuration
local lazy_config = require "configs.lazy"

-- Setup all plugins
require("lazy").setup({
  {
    -- NvChad core plugins and UI
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  -- Our custom plugins (combines NvChad + Kickstart features)
  { import = "plugins" },

  -- Your personal plugins (like kickstart's custom.plugins)
  { import = "custom.plugins" },
}, lazy_config)

-- Load NvChad theme files
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- Load our configuration modules
require "options"   -- Vim options and settings
require "autocmds"  -- Autocommands and event handlers

-- Load keymaps after UI is ready
vim.schedule(function()
  require "mappings"  -- Key mappings and shortcuts
end)
