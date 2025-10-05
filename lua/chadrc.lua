---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "tokyonight",
  theme_toggle = { "tokyonight", "one_light" },

  hl_override = {
    Comment = { italic = false },
  },

  statusline = {
    theme = "default",
    separator_style = "default",
  },
}

return M