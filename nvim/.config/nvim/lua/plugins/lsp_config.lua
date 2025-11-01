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
      "williamboman/mason.nvim",
      "jay-babu/mason-null-ls.nvim",
      "jay-babu/mason-nvim-dap.nvim",
    },
  },
  {
    "folke/neoconf.nvim",
    cmd = "Neoconf",
    dependencies = {
      "neovim/nvim-lspconfig", -- Required for neoconf utilities, but not used for config
    },
    opts = {},
  },
  { "folke/lazydev.nvim", opts = {} },
  -- Neovim 0.11+ native LSP configuration (no nvim-lspconfig needed)
  {
    "dummy/lsp-native-config",
    dir = vim.fn.stdpath("config"),
    lazy = false,
    priority = 1000,
    config = function()
      require("neoconf").setup()
      require("mason").setup()
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
        automatic_installation = false,
      })

      -- Mason tool installer (for installation only, not configuration)
      mason_tool_install.setup({
        ensure_installed = {
          "lua-language-server",
          "bash-language-server",
          "gopls",
          "elixir-ls",
          "html-lsp",
          "typescript-language-server",
          "rust-analyzer",
          "ansible-language-server",
          "json-lsp",
          "yaml-language-server",
          "htmx-lsp",
          "css-lsp",
          "emmet-ls",
          "templ",
          "astro-language-server",
          "tailwindcss-language-server",
          "jsonlint",
          "pyright",
          "clangd",
        },
        auto_update = true,
        run_on_start = true,
        integrations = {
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

        -- Only apply the first successful action to avoid duplicates from multiple LSP clients
        local applied = false
        for _, res in pairs(result) do
          if not applied then
            for _, action in pairs(res.result or {}) do
              if action.edit then
                vim.lsp.util.apply_workspace_edit(action.edit, "utf-8")
                applied = true
                break
              elseif action.command then
                vim.lsp.buf.execute_command(action.command)
                applied = true
                break
              end
            end
          end
        end
      end

      -- Modern LspAttach autocmd (replaces on_attach callbacks)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if not client then
            return
          end

          -- Enable semantic tokens if available
          if client.server_capabilities.semanticTokensProvider then
            vim.lsp.semantic_tokens.start(ev.buf, client.id)
          end

          -- Enable inlay hints if available
          if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
          end

          -- Auto-import on save (check if code actions are supported)
          local supports_code_action = client.server_capabilities.codeActionProvider
          if supports_code_action ~= nil and supports_code_action ~= false then
            local augroup = vim.api.nvim_create_augroup("LspAutoImport_" .. ev.buf, { clear = true })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = ev.buf,
              callback = function()
                organize_imports_sync(ev.buf, 1000)
              end,
              desc = "Auto-organize imports on save",
            })
          end
        end,
      })

      -- Configure LSP servers using vim.lsp.config (Neovim 0.11+)
      -- Servers with custom settings
      vim.lsp.config.gopls = {
        cmd = { "gopls" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_markers = { "go.work", "go.mod", ".git" },
        capabilities = lsp_capabilities,
        settings = require("plugins.lsp_lang_settings.gopls").settings,
      }

      vim.lsp.config.lua_ls = {
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" },
        capabilities = lsp_capabilities,
        settings = require("plugins.lsp_lang_settings.lua_ls").settings,
      }

      vim.lsp.config.jsonls = {
        cmd = { "vscode-json-language-server", "--stdio" },
        filetypes = { "json", "jsonc" },
        root_markers = { ".git" },
        capabilities = lsp_capabilities,
        settings = require("plugins.lsp_lang_settings.jsonls").settings,
      }

      vim.lsp.config.yamlls = {
        cmd = { "yaml-language-server", "--stdio" },
        filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
        root_markers = { ".git" },
        capabilities = lsp_capabilities,
        settings = require("plugins.lsp_lang_settings.yamlls").settings,
      }

      vim.lsp.config.ansiblels = {
        cmd = { "ansible-language-server", "--stdio" },
        filetypes = { "yaml.ansible" },
        root_markers = { "ansible.cfg", ".ansible-lint", ".git" },
        capabilities = lsp_capabilities,
        settings = require("plugins.lsp_lang_settings.ansible").settings,
      }

      vim.lsp.config.ts_ls = {
        cmd = { "typescript-language-server", "--stdio" },
        filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
        root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
        capabilities = lsp_capabilities,
        settings = require("plugins.lsp_lang_settings.typescript").settings,
      }

      vim.lsp.config.rust_analyzer = {
        cmd = { "rust-analyzer" },
        filetypes = { "rust" },
        root_markers = { "Cargo.toml", "rust-project.json", ".git" },
        capabilities = lsp_capabilities,
        settings = require("plugins.lsp_lang_settings.rust").settings,
      }

      vim.lsp.config.pyright = {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", "pyrightconfig.json", ".git" },
        capabilities = lsp_capabilities,
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
      }

      vim.lsp.config.clangd = {
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm",
        },
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
        root_markers = { ".clangd", ".clang-tidy", ".clang-format", "compile_commands.json", "compile_flags.txt", "configure.ac", ".git" },
        capabilities = lsp_capabilities,
        init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          clangdFileStatus = true,
        },
      }

      -- Servers using defaults (no custom settings)
      vim.lsp.config.bashls = {
        cmd = { "bash-language-server", "start" },
        filetypes = { "sh", "bash" },
        root_markers = { ".git" },
        capabilities = lsp_capabilities,
      }

      vim.lsp.config.elixirls = {
        cmd = { "elixir-ls" },
        filetypes = { "elixir", "eelixir", "heex", "surface" },
        root_markers = { "mix.exs", ".git" },
        capabilities = lsp_capabilities,
      }

      vim.lsp.config.html = {
        cmd = { "vscode-html-language-server", "--stdio" },
        filetypes = { "html", "templ" },
        root_markers = { ".git" },
        capabilities = lsp_capabilities,
      }

      vim.lsp.config.htmx = {
        cmd = { "htmx-lsp" },
        filetypes = { "html", "templ" },
        root_markers = { ".git" },
        capabilities = lsp_capabilities,
      }

      vim.lsp.config.cssls = {
        cmd = { "vscode-css-language-server", "--stdio" },
        filetypes = { "css", "scss", "less" },
        root_markers = { ".git" },
        capabilities = lsp_capabilities,
      }

      vim.lsp.config.emmet_ls = {
        cmd = { "emmet-ls", "--stdio" },
        filetypes = { "html", "css", "scss", "javascriptreact", "typescriptreact", "vue", "svelte" },
        root_markers = { ".git" },
        capabilities = lsp_capabilities,
      }

      vim.lsp.config.templ = {
        cmd = { "templ", "lsp" },
        filetypes = { "templ" },
        root_markers = { "go.mod", ".git" },
        capabilities = lsp_capabilities,
      }

      vim.lsp.config.astro = {
        cmd = { "astro-ls", "--stdio" },
        filetypes = { "astro" },
        root_markers = { "package.json", "astro.config.mjs", ".git" },
        capabilities = lsp_capabilities,
      }

      vim.lsp.config.tailwindcss = {
        cmd = { "tailwindcss-language-server", "--stdio" },
        filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
        root_markers = { "tailwind.config.js", "tailwind.config.cjs", "tailwind.config.ts", ".git" },
        capabilities = lsp_capabilities,
      }

      -- Enable all configured servers
      vim.lsp.enable({
        "gopls",
        "lua_ls",
        "jsonls",
        "yamlls",
        "ansiblels",
        "ts_ls",
        "rust_analyzer",
        "pyright",
        "clangd",
        "bashls",
        "elixirls",
        "html",
        "htmx",
        "cssls",
        "emmet_ls",
        "templ",
        "astro",
        "tailwindcss",
      })

      -- Diagnostic configuration
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "󱐋 ",
            [vim.diagnostic.severity.WARN] = "󱐋 ",
            [vim.diagnostic.severity.HINT] = "» ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
          severity = { min = vim.diagnostic.severity.WARN },
        },
        severity_sort = true,
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

      -- LSP progress indicator
      if vim.lsp.progress then
        vim.lsp.progress.enable(true)
      end

      -- LSP hover and signature help borders
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
        max_width = math.floor(vim.o.columns * 0.7),
        max_height = math.floor(vim.o.lines * 0.3),
      })

      -- Note: Auto-format on save is handled by conform.nvim
    end,
  },
}
