-- ============================================================================
-- NEO-TREE CONFIGURATION
-- ============================================================================
-- File explorer replacement for nvim-tree with better features

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
    { "<C-n>", "<cmd>Neotree toggle<cr>", desc = "Toggle NeoTree" },
  },
  init = function()
    -- Disable netrw completely
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- Only auto-open for directories, not files
    vim.api.nvim_create_autocmd("VimEnter", {
      once = true,
      callback = function()
        local arg = vim.fn.argv(0)
        if vim.fn.argc() == 1 and vim.fn.isdirectory(arg) == 1 then
          -- We opened a directory, replace it with neo-tree
          vim.defer_fn(function()
            -- Delete directory buffer
            vim.cmd("bd")
            -- Open neo-tree
            vim.cmd("Neotree")
          end, 10)
        end
      end,
    })
  end,
  opts = {
    close_if_last_window = false,
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    filesystem = {
      follow_current_file = {
        enabled = true,
      },
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = false,
      },
    },
    window = {
      position = "left",
      width = 30,
      mappings = {
        ["<space>"] = "none",
      },
    },
  },
}