-- ============================================================================
-- TOGGLETERM PLUGIN
-- ============================================================================
-- Better terminal integration with floating/split terminals

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    opts = {
      size = 20,
      open_mapping = [[<c-\>]], -- Ctrl+\ to toggle terminal
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true, -- Start in insert mode
      insert_mappings = true,
      persist_size = true,
      persist_mode = true,
      direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
      close_on_exit = true,
      shell = vim.o.shell,
      autochdir = false,
      highlights = {
        border = "Normal",
        background = "Normal",
      },
      float_opts = {
        border = "curved", -- 'single' | 'double' | 'shadow' | 'curved'
        width = function()
          return math.ceil(vim.o.columns * 0.8)
        end,
        height = function()
          return math.ceil(vim.o.lines * 0.8)
        end,
        winblend = 0,
      },
    },

    config = function(_, opts)
      require("toggleterm").setup(opts)

      -- Custom terminal functions
      local Terminal = require('toggleterm.terminal').Terminal

      -- Go run terminal
      local function go_run()
        local file = vim.fn.expand('%:p')
        if vim.bo.filetype == 'go' then
          local go_term = Terminal:new({
            cmd = 'go run ' .. file,
            direction = 'float',
            close_on_exit = false, -- Keep open to see output
          })
          go_term:toggle()
        else
          vim.notify("Not a Go file!", vim.log.levels.WARN)
        end
      end

      -- Go test terminal
      local function go_test()
        if vim.bo.filetype == 'go' then
          local go_test_term = Terminal:new({
            cmd = 'go test -v',
            direction = 'float',
            close_on_exit = false,
          })
          go_test_term:toggle()
        else
          vim.notify("Not a Go file!", vim.log.levels.WARN)
        end
      end

      -- Python run terminal
      local function python_run()
        local file = vim.fn.expand('%:p')
        if vim.bo.filetype == 'python' then
          local py_term = Terminal:new({
            cmd = 'python3 ' .. file,
            direction = 'float',
            close_on_exit = false,
          })
          py_term:toggle()
        else
          vim.notify("Not a Python file!", vim.log.levels.WARN)
        end
      end

      -- Set up keymaps
      vim.keymap.set('n', '<leader>tg', go_run, { desc = "Run Go file" })
      vim.keymap.set('n', '<leader>tt', go_test, { desc = "Run Go tests" })
      vim.keymap.set('n', '<leader>tp', python_run, { desc = "Run Python file" })

      -- General terminal keymaps
      vim.keymap.set('n', '<leader>tf', '<cmd>ToggleTerm direction=float<cr>', { desc = "Float terminal" })
      vim.keymap.set('n', '<leader>th', '<cmd>ToggleTerm size=10 direction=horizontal<cr>', { desc = "Horizontal terminal" })
      vim.keymap.set('n', '<leader>tv', '<cmd>ToggleTerm size=80 direction=vertical<cr>', { desc = "Vertical terminal" })

      -- Terminal mode keymaps
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], { desc = "Exit terminal mode" })
      vim.keymap.set('t', '<esc><esc>', '<cmd>ToggleTerm<cr>', { desc = "Close terminal" })
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], { desc = "Terminal left" })
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], { desc = "Terminal down" })
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], { desc = "Terminal up" })
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], { desc = "Terminal right" })
    end,
  }
}