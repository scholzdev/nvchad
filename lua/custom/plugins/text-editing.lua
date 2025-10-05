-- ============================================================================
-- TEXT EDITING ENHANCEMENTS
-- ============================================================================
-- Advanced text editing and manipulation tools

return {
  -- Better text objects
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
        },
      }
    end,
  },

  -- Advanced surround operations
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        keymaps = {
          insert = "<C-g>s",
          insert_line = "<C-g>S",
          normal = "ys",
          normal_cur = "yss",
          normal_line = "yS",
          normal_cur_line = "ySS",
          visual = "S",
          visual_line = "gS",
          delete = "ds",
          change = "cs",
        },
      })
    end,
  },

  -- Align text
  {
    "echasnovski/mini.align",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "ga", mode = { "n", "v" }, desc = "Align" },
      { "gA", mode = { "n", "v" }, desc = "Align with preview" },
    },
  },

  -- Split/join code blocks
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
      { "<leader>m", "<cmd>TSJToggle<cr>", desc = "Toggle split/join" },
    },
    opts = { use_default_keymaps = false },
  },

  -- Better increment/decrement
  {
    "monaqa/dial.nvim",
    keys = {
      { "<C-a>", function() require("dial.map").manipulate("increment", "normal") end, desc = "Increment" },
      { "<C-x>", function() require("dial.map").manipulate("decrement", "normal") end, desc = "Decrement" },
      { "g<C-a>", function() require("dial.map").manipulate("increment", "gnormal") end, desc = "Increment" },
      { "g<C-x>", function() require("dial.map").manipulate("decrement", "gnormal") end, desc = "Decrement" },
      { "<C-a>", function() require("dial.map").manipulate("increment", "visual") end, mode = "v", desc = "Increment" },
      { "<C-x>", function() require("dial.map").manipulate("decrement", "visual") end, mode = "v", desc = "Decrement" },
      { "g<C-a>", function() require("dial.map").manipulate("increment", "gvisual") end, mode = "v", desc = "Increment" },
      { "g<C-x>", function() require("dial.map").manipulate("decrement", "gvisual") end, mode = "v", desc = "Decrement" },
    },
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.constant.alias.bool,
          augend.semver.alias.semver,
        },
      })
    end,
  },
}