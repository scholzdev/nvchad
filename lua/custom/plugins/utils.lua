-- ============================================================================
-- ADDITIONAL UTILITY PLUGINS
-- ============================================================================
-- Collection of smaller utility plugins

return {
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

  -- Autopairs - automatically close brackets, quotes, etc.
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true, -- Use default configuration
  },

  -- Indent guides - show indentation levels
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
    opts = {
      -- Add any custom configuration here
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
  },

  -- Todo comments - highlight and search TODO comments
  {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = false, -- Disable signs in sign column
    },
  },

  -- LazyDev - better Lua development for Neovim config
  {
    "folke/lazydev.nvim",
    ft = "lua", -- Only load for Lua files
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  -- Guess indent - automatically detect indentation
  {
    "NMAC427/guess-indent.nvim",
    lazy = false,
    config = true, -- Use default configuration
  },
}