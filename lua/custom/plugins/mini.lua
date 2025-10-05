-- ============================================================================
-- MINI.NVIM CONFIGURATION
-- ============================================================================
-- Collection of useful mini plugins from kickstart.nvim

return {
  "echasnovski/mini.nvim",
  config = function()
    -- Better Around/Inside textobjects
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    -- Examples:
    --  - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    --  - sd'   - [S]urround [D]elete [']quotes
    --  - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

    -- Simple and easy statusline (optional, since NvChad has its own)
    -- Uncomment if you prefer mini.statusline over NvChad's statusline
    -- local statusline = require 'mini.statusline'
    -- statusline.setup { use_icons = vim.g.have_nerd_font }
  end,
}