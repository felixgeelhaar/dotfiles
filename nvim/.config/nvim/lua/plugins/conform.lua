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
          require("conform").format({ async = true, lsp_fallback = true })
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
      -- Define formatters by filetype
      formatters_by_ft = {
        -- JavaScript/TypeScript
        javascript = { "prettier", "eslint_d" },
        javascriptreact = { "prettier", "eslint_d" },
        typescript = { "prettier", "eslint_d" },
        typescriptreact = { "prettier", "eslint_d" },
        vue = { "prettier" },
        svelte = { "prettier" },
        
        -- Web
        css = { "prettier" },
        scss = { "prettier" },
        less = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier", "markdownlint" },
        ["markdown.mdx"] = { "prettier" },
        graphql = { "prettier" },
        handlebars = { "prettier" },
        
        -- Python
        python = { "ruff_format", "black", stop_after_first = true },
        
        -- Rust
        rust = { "rustfmt" },
        
        -- Go
        go = { "goimports", "gofumpt" },
        
        -- Lua
        lua = { "stylua" },
        
        -- Shell
        sh = { "shfmt", "shellcheck" },
        bash = { "shfmt", "shellcheck" },
        zsh = { "shfmt" },
        fish = { "fish_indent" },
        
        -- C/C++
        c = { "clang_format" },
        cpp = { "clang_format" },
        
        -- Java
        java = { "google-java-format" },
        
        -- SQL
        sql = { "sql_formatter" },
        mysql = { "sql_formatter" },
        postgresql = { "sql_formatter" },
        
        -- Configuration files
        toml = { "taplo" },
        terraform = { "terraform_fmt" },
        tf = { "terraform_fmt" },
        ["terraform-vars"] = { "terraform_fmt" },
        
        -- Docker
        dockerfile = { "hadolint" },
        
        -- Use the "*" filetype to run formatters on all filetypes
        ["*"] = { "codespell", "trim_whitespace" },
        -- Use the "_" filetype to run formatters on filetypes that don't
        -- have other formatters configured
        ["_"] = { "trim_whitespace" },
      },
      
      -- Customize formatters
      formatters = {
        prettier = {
          prepend_args = { "--single-quote", "--jsx-single-quote" },
        },
        black = {
          prepend_args = { "--line-length", "100" },
        },
        stylua = {
          prepend_args = { "--indent-type", "Tabs", "--indent-width", "2" },
        },
        shfmt = {
          prepend_args = { "-i", "2", "-ci" },
        },
        sql_formatter = {
          prepend_args = { "--language", "postgresql" },
        },
        eslint_d = {
          condition = function(self, ctx)
            return vim.fs.find({ ".eslintrc", ".eslintrc.js", ".eslintrc.json" }, { path = ctx.filename, upward = true })[1]
          end,
        },
        markdownlint = {
          prepend_args = { "--fix" },
        },
        ruff_format = {
          prepend_args = { "--line-length", "100" },
        },
        gofumpt = {
          prepend_args = { "-extra" },
        },
        injected = {
          options = {
            ignore_errors = true,
          },
        },
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
      notify_on_error = true,
      
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