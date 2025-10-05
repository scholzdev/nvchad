-- ============================================================================
-- THEME OVERRIDES
-- ============================================================================
-- Custom theme configuration and disabled default plugins

return {
  -- Disable default NvChad plugins that we're replacing
  {
    "NvChad/nvim-colorizer.lua",
    enabled = false,
  },

  -- Completely disable nvim-tree since we're using neo-tree
  {
    "nvim-tree/nvim-tree.lua",
    enabled = false,
    lazy = false,
    config = function() end, -- Override any config
  },

  -- Also disable any potential NvChad nvim-tree config
  {
    "nvim-tree",
    enabled = false,
  },

  -- Enhanced file icons with better recognition
  {
    "nvim-tree/nvim-web-devicons",
    priority = 1000, -- Load early for other plugins
    config = function()
      require("nvim-web-devicons").setup {
        -- Globally enable default icons
        default = true,
        -- Strict mode: only show icons for files with recognized extensions
        strict = false,
        -- Define custom icons for special files
        override_by_filename = {
          ["lazy-lock.json"] = {
            icon = "󰒲",
            color = "#519aba",
            name = "LazyLock"
          },
          [".luarc.json"] = {
            icon = "",
            color = "#519aba",
            name = "LuaRC"
          },
          [".stylua.toml"] = {
            icon = "",
            color = "#519aba",
            name = "StyLua"
          },
          ["init.lua"] = {
            icon = "",
            color = "#519aba",
            name = "LuaInit"
          },
        },
        -- Define icons by file extension
        override_by_extension = {
          ["toml"] = {
            icon = "",
            color = "#519aba",
            name = "toml"
          },
          ["lock"] = {
            icon = "",
            color = "#c4a7e7",
            name = "lock"
          },
        },
      }
    end,
  },

  -- Tokyonight theme (optional override)
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      require("tokyonight").setup {
        styles = {
          comments = { italic = false },
        },
      }
      -- Uncomment to use tokyonight instead of NvChad theme
      -- vim.cmd.colorscheme "tokyonight"
    end,
  },
}