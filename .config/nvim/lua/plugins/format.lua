return {
  'stevearc/conform.nvim',
  lazy = true,
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local conform = require 'conform'

    conform.setup {
      notify_on_error = false,
      formatters_by_ft = {
        lua = { 'stylua' },
        html = { 'prettier' },
        json = { 'prettier' },
        yaml = { 'yamlfmt' },
        markdown = { 'prettier' },
        go = { 'goimports' },
        javascript = { 'prettierd', 'prettier' },
        typescript = { 'prettierd', 'prettier' },
        astro = { 'prettier', 'prettier' },
        -- python = { 'isort', 'black' },
      },
      format_on_save = {
        lsp_fallback = true,
        timeout_ms = 500,
      },
    }

    vim.keymap.set({ 'n', 'v' }, '<leader>cf', function()
      conform.format { lsp_fallback = true, async = false, timeout_ms = 1000 }
    end, { desc = 'Format file or range (in visual mode)' })
  end,
}
