-- Modern code formatting with conform.nvim
return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ 
            async = true, 
            lsp_fallback = true,
            quiet = true, -- Don't show errors for missing formatters
          })
        end,
        mode = "",
        desc = "Format Buffer",
      },
      {
        "<leader>cF",
        function()
          require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
        end,
        mode = { "n", "v" },
        desc = "Format Injected Languages",
      },
    },
    opts = {
      -- Define formatters by filetype (only commonly available ones)
      formatters_by_ft = {
        -- JavaScript/TypeScript (fallback to LSP if prettier not available)
        javascript = { "prettier", stop_after_first = true },
        javascriptreact = { "prettier", stop_after_first = true },
        typescript = { "prettier", stop_after_first = true },
        typescriptreact = { "prettier", stop_after_first = true },
        
        -- Web formats
        css = { "prettier", stop_after_first = true },
        html = { "prettier", stop_after_first = true },
        json = { "prettier", stop_after_first = true },
        yaml = { "prettier", stop_after_first = true },
        markdown = { "prettier", stop_after_first = true },
        
        -- Languages with built-in formatters
        go = { "gofmt", stop_after_first = true },
        rust = { "rustfmt", stop_after_first = true },
        lua = { "stylua", stop_after_first = true },
        python = { "black", stop_after_first = true },
        
        -- Use the "_" filetype to run formatters on filetypes that don't
        -- have other formatters configured (basic cleanup)
        ["_"] = { "trim_whitespace" },
      },
      
      -- Customize formatters (basic configurations)
      formatters = {
        -- Custom formatter for removing trailing whitespace
        -- Define custom formatter for removing trailing whitespace
        trim_whitespace = {
          command = "sed",
          args = { "-i", "s/[[:space:]]*$//" },
          stdin = false,
        },
      },
      
      -- Format on save configuration
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        
        -- Disable autoformat for specific filetypes
        local ignore_filetypes = { "sql", "java" }
        if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
          return
        end
        
        return {
          timeout_ms = 500,
          lsp_fallback = true,
          async = false,
        }
      end,
      
      -- Format after save configuration (async)
      format_after_save = function(bufnr)
        -- Only for specific slow formatters
        local slow_filetypes = { "java", "cpp" }
        if not vim.tbl_contains(slow_filetypes, vim.bo[bufnr].filetype) then
          return
        end
        
        return {
          timeout_ms = 3000,
          lsp_fallback = true,
          async = true,
        }
      end,
      
      -- Set to true to automatically format on save
      notify_on_error = false, -- Don't notify on formatter errors
      
      -- Use LSP formatting as fallback
      lsp_fallback = true,
    },
    init = function()
      -- Create user commands for toggling autoformat
      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          -- FormatDisable! will disable formatting just for this buffer
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })
      
      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Re-enable autoformat-on-save",
      })
      
      -- Note: ConformInfo is available as a command, not a function for statusline
    end,
  },
}