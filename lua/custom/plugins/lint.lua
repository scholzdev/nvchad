-- ============================================================================
-- LINTING CONFIGURATION
-- ============================================================================
-- Asynchronous linting with nvim-lint

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require 'lint'

    -- Configure linters by filetype
    lint.linters_by_ft = {
      markdown = { 'markdownlint' },
      -- Add more linters here as needed:
      -- python = { 'pylint' },
      -- javascript = { 'eslint' },
    }

    -- Create autocommand which carries out the actual linting
    -- on the specified events.
    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        -- Only lint if the buffer is modifiable (not read-only)
        if vim.bo.modifiable then
          lint.try_lint()
        end
      end,
    })
  end,
}