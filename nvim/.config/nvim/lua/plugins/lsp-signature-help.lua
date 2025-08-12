-- Enhanced signature help configuration
-- This file sets up automatic signature help display when typing function arguments

return {
  -- Additional plugin for enhanced signature help if blink.cmp's built-in isn't sufficient
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {
      bind = true,
      handler_opts = {
        border = "rounded",
      },
      floating_window = true,
      floating_window_above_cur_line = true,
      hint_enable = false, -- Disable inline hints since we have inlay hints
      hi_parameter = "LspSignatureActiveParameter",
      max_height = 12,
      max_width = 80,
      transparency = nil,
      toggle_key = "<M-x>", -- Alt+x to toggle signature help
      select_signature_key = "<M-n>", -- Alt+n to cycle through signatures
      move_cursor_key = nil,
    },
    config = function(_, opts)
      require("lsp_signature").setup(opts)
      
      -- Auto-trigger on specific characters for TypeScript/JavaScript
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        callback = function()
          vim.api.nvim_create_autocmd("TextChangedI", {
            buffer = 0,
            callback = function()
              local col = vim.fn.col('.') - 1
              local line = vim.fn.getline('.')
              local char = line:sub(col, col)
              
              -- Trigger on opening parenthesis or comma
              if char == '(' or char == ',' then
                vim.defer_fn(function()
                  vim.lsp.buf.signature_help()
                end, 50)
              end
            end,
          })
        end,
      })
    end,
  },
}