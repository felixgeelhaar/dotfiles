return {
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'

      lint.linters_by_ft = {
        markdown = { 'markdownlint' },
        json = { 'jsonlint' },
        rst = { 'vale' },
        text = { 'vale' },
        typescript = { 'eslint' },
        javascript = { 'eslint' },
        astro = { 'eslint' },
        go = { 'golangcilint' },
      }
      lint.linters_by_ft = lint.linters_by_ft or {}

      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          require('lint').try_lint()
        end,
      })
    end,
  },
}
