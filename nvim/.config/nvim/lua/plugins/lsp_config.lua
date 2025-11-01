return {
  {
    "williamboman/mason.nvim",
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "jay-babu/mason-null-ls.nvim",
      "jay-babu/mason-nvim-dap.nvim",
    },
  },
  { "folke/neoconf.nvim", cmd = "Neoconf", opts = {} },
  { "folke/lazydev.nvim", opts = {} },
  -- Native inlay hints support (Neovim 0.10+)
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      require("neoconf").setup()
      require("mason").setup()
      local lspconfig = require("lspconfig")
      local mason_lsp = require("mason-lspconfig")
      local mason_tool_install = require("mason-tool-installer")

      local lsp_capabilities = require("blink.cmp").get_lsp_capabilities()
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
        focusable = false,
        silent = true,
        max_width = 80,
        max_height = 20,
      })

      require("mason-null-ls").setup({
        ensure_installed = {},
        -- Disable automatic installation to prevent stylua from being auto-configured
        -- stylua is handled by conform.nvim as a formatter, not null-ls as LSP
        automatic_installation = false,
      })

      mason_tool_install.setup({
        ensure_installed = {
          "lua_ls",
          "bashls",
          "gopls",
          "elixirls",
          "html",
          "ts_ls",
          "rust_analyzer",
          "ansiblels",
          "jsonls",
          "yamlls",
          "htmx",
          "cssls",
          "emmet_ls",
          "templ",
          "astro",
          "tailwindcss",
          "jsonlint",
          "pyright", -- Python LSP
          "clangd", -- C/C++ LSP
        },
        auto_update = true,
        run_on_start = true,
        integrations = {
          ["mason-lspconfig"] = true,
          ["mason-null-ls"] = true,
          ["mason-nvim-dap"] = true,
        },
      })

      -- Helper function to organize imports before save
      local function organize_imports_sync(bufnr, timeout_ms)
        local params = vim.lsp.util.make_range_params()
        params.context = { only = { "source.organizeImports" } }

        local result = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, timeout_ms or 3000)
        if not result or vim.tbl_isempty(result) then
          return
        end

        for _, res in pairs(result) do
          for _, action in pairs(res.result or {}) do
            if action.edit then
              vim.lsp.util.apply_workspace_edit(action.edit, "utf-8")
            elseif action.command then
              vim.lsp.buf.execute_command(action.command)
            end
          end
        end
      end

      local handlers = {
        -- Default handler
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = lsp_capabilities,
            on_attach = function(client, bufnr)
              -- Enable semantic tokens if available
              if client.server_capabilities.semanticTokensProvider then
                vim.lsp.semantic_tokens.start(bufnr, client.id)
              end

              -- Enable inlay hints if available (Neovim 0.10+)
              if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
                vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
              end

              -- Auto-import on save
              -- Only set up if the LSP supports code actions
              if client.server_capabilities.codeActionProvider then
                local augroup = vim.api.nvim_create_augroup("LspAutoImport_" .. bufnr, { clear = true })
                vim.api.nvim_create_autocmd("BufWritePre", {
                  group = augroup,
                  buffer = bufnr,
                  callback = function()
                    -- Organize imports before format
                    organize_imports_sync(bufnr, 1000)
                  end,
                  desc = "Auto-organize imports on save",
                })
              end
            end,
          })
        end,

        -- Shared on_attach function for language-specific handlers
        local function common_on_attach(client, bufnr)
          -- Enable semantic tokens if available
          if client.server_capabilities.semanticTokensProvider then
            vim.lsp.semantic_tokens.start(bufnr, client.id)
          end

          -- Enable inlay hints if available (Neovim 0.10+)
          if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end

          -- Auto-import on save
          if client.server_capabilities.codeActionProvider then
            local augroup = vim.api.nvim_create_augroup("LspAutoImport_" .. bufnr, { clear = true })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                organize_imports_sync(bufnr, 1000)
              end,
              desc = "Auto-organize imports on save",
            })
          end
        end

        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            capabilities = lsp_capabilities,
            on_attach = common_on_attach,
            settings = require("plugins.lsp_lang_settings.lua_ls").settings,
          })
        end,

        ["jsonls"] = function()
          lspconfig.jsonls.setup({
            capabilities = lsp_capabilities,
            on_attach = common_on_attach,
            settings = require("plugins.lsp_lang_settings.jsonls").settings,
          })
        end,

        ["yamlls"] = function()
          lspconfig.yamlls.setup({
            capabilities = lsp_capabilities,
            on_attach = common_on_attach,
            settings = require("plugins.lsp_lang_settings.yamlls").settings,
          })
        end,

        ["gopls"] = function()
          lspconfig.gopls.setup({
            capabilities = lsp_capabilities,
            on_attach = common_on_attach,
            settings = require("plugins.lsp_lang_settings.gopls").settings,
          })
        end,

        ["ansiblels"] = function()
          lspconfig.ansiblels.setup({
            capabilities = lsp_capabilities,
            on_attach = common_on_attach,
            settings = require("plugins.lsp_lang_settings.ansible").settings,
          })
        end,
        ["ts_ls"] = function()
          lspconfig.ts_ls.setup({
            capabilities = lsp_capabilities,
            on_attach = common_on_attach,
            settings = require("plugins.lsp_lang_settings.typescript").settings,
          })
        end,
        ["rust_analyzer"] = function()
          lspconfig.rust_analyzer.setup({
            capabilities = lsp_capabilities,
            on_attach = common_on_attach,
            settings = require("plugins.lsp_lang_settings.rust").settings,
          })
        end,
        ["pyright"] = function()
          lspconfig.pyright.setup({
            capabilities = lsp_capabilities,
            on_attach = common_on_attach,
            settings = {
              python = {
                analysis = {
                  autoSearchPaths = true,
                  diagnosticMode = "workspace",
                  useLibraryCodeForTypes = true,
                  typeCheckingMode = "basic",
                },
              },
            },
          })
        end,
        ["clangd"] = function()
          lspconfig.clangd.setup({
            capabilities = lsp_capabilities,
            on_attach = common_on_attach,
            cmd = {
              "clangd",
              "--background-index",
              "--clang-tidy",
              "--header-insertion=iwyu",
              "--completion-style=detailed",
              "--function-arg-placeholders",
              "--fallback-style=llvm",
            },
            init_options = {
              usePlaceholders = true,
              completeUnimported = true,
              clangdFileStatus = true,
            },
          })
        end,
      }

      mason_lsp.setup({ handlers = handlers })

      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "󱐋 ",
            [vim.diagnostic.severity.WARN] = "󱐋 ",
            [vim.diagnostic.severity.HINT] = "» ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
          -- Limit virtual text to reduce visual noise
          severity = { min = vim.diagnostic.severity.WARN },
        },
        severity_sort = true,
        -- Reduce diagnostic update frequency
        underline = {
          severity = { min = vim.diagnostic.severity.WARN },
        },
        float = {
          focusable = true,
          style = "minimal",
          border = "rounded",
          source = true,
          header = "",
          prefix = " ● ",
          -- Add max width/height to prevent huge popups
          max_width = 80,
          max_height = 20,
        },
        document_highlight = {
          enabled = true,
        },
        codelens = {
          enabled = false,
        },
      })
      -- Modern LSP progress indicator (if available)
      if vim.lsp.progress then
        vim.lsp.progress.enable(true)
      end

      -- Set up LSP hover and signature help borders
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
        max_width = math.floor(vim.o.columns * 0.7),
        max_height = math.floor(vim.o.lines * 0.3),
      })

      -- Note: Auto-format on save is handled by conform.nvim
      -- See lua/plugins/conform.lua for format configuration
    end,
  },
}
