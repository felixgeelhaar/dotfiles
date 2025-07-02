-- Additional Language Server Configuration
-- This file extends the base LSP configuration with additional language servers

return {
  -- JSON/YAML Schema Store for enhanced completion
  {
    "b0o/schemastore.nvim",
    lazy = true,
  },
  
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        -- Language servers
        "pyright",           -- Python
        "ruff-lsp",          -- Python linting/formatting
        "gopls",             -- Go
        "rust-analyzer",     -- Rust
        "java-language-server", -- Java
        "kotlin-language-server", -- Kotlin
        "clangd",            -- C/C++
        "cmake-language-server", -- CMake
        "dockerfile-language-server", -- Docker
        "docker-compose-language-service", -- Docker Compose
        "yaml-language-server", -- YAML
        "json-lsp",          -- JSON
        "html-lsp",          -- HTML
        "css-lsp",           -- CSS
        "tailwindcss-language-server", -- Tailwind CSS
        "svelte-language-server", -- Svelte
        "vue-language-server", -- Vue.js
        "prisma-language-server", -- Prisma
        "graphql-language-service-cli", -- GraphQL
        "terraform-ls",      -- Terraform
        "ansible-language-server", -- Ansible
        "bash-language-server", -- Bash
        "powershell-editor-services", -- PowerShell
        
        -- Formatters
        "prettier",          -- Web technologies
        "black",             -- Python
        "isort",             -- Python imports
        "gofumpt",           -- Go
        "rustfmt",           -- Rust
        "google-java-format", -- Java
        "clang-format",      -- C/C++
        "stylua",            -- Lua
        "shfmt",             -- Shell scripts
        "terraform-fmt",     -- Terraform
        "yamlfmt",           -- YAML
        
        -- Linters
        "pylint",            -- Python
        "flake8",            -- Python
        "mypy",              -- Python type checking
        "golangci-lint",     -- Go
        "clippy",            -- Rust
        "eslint_d",          -- JavaScript/TypeScript
        "shellcheck",        -- Shell scripts
        "hadolint",          -- Dockerfile
        "markdownlint",      -- Markdown
        -- "vale",           -- Prose linting (optional, requires .vale.ini config)
        
        -- Debuggers
        "debugpy",           -- Python
        "delve",             -- Go
        "codelldb",          -- Rust/C/C++
        "js-debug-adapter",  -- JavaScript/TypeScript
        "node-debug2-adapter", -- Node.js
      })
    end,
  },
  
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Python
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                autoImportCompletions = true,
                diagnosticMode = "workspace",
              },
            },
          },
        },
        ruff_lsp = {
          settings = {
            args = {
              "--config=pyproject.toml",
            },
          },
        },
        
        -- Go
        gopls = {
          settings = {
            gopls = {
              gofumpt = true,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                fieldalignment = true,
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
              semanticTokens = true,
            },
          },
        },
        
        -- Rust
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              imports = {
                granularity = {
                  group = "module",
                },
                prefix = "self",
              },
              cargo = {
                buildScripts = {
                  enable = true,
                },
              },
              procMacro = {
                enable = true,
              },
              checkOnSave = {
                command = "clippy",
              },
            },
          },
        },
        
        -- Java
        jdtls = {
          settings = {
            java = {
              configuration = {
                updateBuildConfiguration = "interactive",
              },
              compile = {
                nullAnalysis = {
                  mode = "automatic",
                },
              },
              completion = {
                favoriteStaticMembers = {
                  "org.hamcrest.MatcherAssert.assertThat",
                  "org.hamcrest.Matchers.*",
                  "org.hamcrest.CoreMatchers.*",
                  "org.junit.jupiter.api.Assertions.*",
                  "java.util.Objects.requireNonNull",
                  "java.util.Objects.requireNonNullElse",
                  "org.mockito.Mockito.*",
                },
              },
              sources = {
                organizeImports = {
                  starThreshold = 9999,
                  staticStarThreshold = 9999,
                },
              },
            },
          },
        },
        
        -- C/C++
        clangd = {
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
        },
        
        -- Web Technologies
        html = {
          filetypes = { "html", "templ" },
        },
        
        tailwindcss = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
          end,
        },
        
        -- DevOps
        terraformls = {
          settings = {
            terraform = {
              validation = {
                enabled = true,
              },
            },
          },
        },
        
        dockerls = {},
        docker_compose_language_service = {},
        
        -- Shell
        bashls = {
          filetypes = { "sh", "bash", "zsh" },
        },
        
        -- YAML
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
              format = {
                enable = true,
              },
              validate = true,
              schemaStore = {
                enable = false,
                url = "",
              },
              schemas = (function()
                local ok, schemastore = pcall(require, "schemastore")
                return ok and schemastore.yaml.schemas() or {}
              end)(),
            },
          },
        },
        
        -- JSON
        jsonls = {
          settings = {
            json = {
              schemas = (function()
                local ok, schemastore = pcall(require, "schemastore")
                return ok and schemastore.json.schemas() or {}
              end)(),
              validate = { enable = true },
            },
          },
        },
      },
    },
  },
  
  -- Schema store for JSON/YAML
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false, -- last release is way too old
  },
}