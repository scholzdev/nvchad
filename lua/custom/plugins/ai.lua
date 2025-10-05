-- ============================================================================
-- AI CODE ASSISTANTS
-- ============================================================================
-- GitHub Copilot and other AI-powered coding assistants

return {
  -- GitHub Copilot - Lua version with better inline suggestions
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true,
          auto_refresh = false,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>"
          },
          layout = {
            position = "bottom",
            ratio = 0.4
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true, -- Show suggestions automatically
          hide_during_completion = false, -- Show alongside completion
          debounce = 50, -- Faster response
          keymap = {
            accept = "<Tab>", -- Accept suggestion (VSCode style)
            accept_word = "<C-Right>", -- Accept just one word
            accept_line = "<C-Down>", -- Accept just one line
            next = "<M-]>", -- Alt+] Next suggestion
            prev = "<M-[>", -- Alt+[ Previous suggestion
            dismiss = "<C-e>", -- Dismiss suggestion
          },
        },
        filetypes = {
          yaml = true,
          markdown = true,
          help = false,
          gitcommit = true,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
          -- Enable for your languages
          lua = true,
          go = true,
          python = true,
          rust = true,
          javascript = true,
          typescript = true,
          c = true,
          cpp = true,
          java = true,
          html = true,
          css = true,
          json = true,
        },
        copilot_node_command = 'node',
        server_opts_overrides = {},
      })
    end,
  },

  -- Copilot CMP integration for even better completion
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },

  -- Copilot Chat for AI conversations
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- Updated dependency
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    opts = {
      debug = false,
      show_help = "yes",
      disable_extra_info = 'no',
      language = "English"
    },
    keys = {
      { "<leader>ai", "<cmd>CopilotChat<cr>", desc = "Open Copilot Chat" },
      { "<leader>ae", "<cmd>CopilotChatExplain<cr>", desc = "Explain code" },
      { "<leader>ar", "<cmd>CopilotChatReview<cr>", desc = "Review code" },
      { "<leader>af", "<cmd>CopilotChatFix<cr>", desc = "Fix code" },
      { "<leader>ao", "<cmd>CopilotChatOptimize<cr>", desc = "Optimize code" },
      { "<leader>ad", "<cmd>CopilotChatDocs<cr>", desc = "Generate docs" },
      { "<leader>at", "<cmd>CopilotChatTests<cr>", desc = "Generate tests" },
      {
        "<leader>av",
        ":CopilotChatVisual",
        mode = "x",
        desc = "Chat with visual selection",
      },
    },
  },
}