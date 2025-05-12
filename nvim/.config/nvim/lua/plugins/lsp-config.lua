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
	{ "folke/neoconf.nvim",  cmd = "Neoconf", opts = {} },
	{ "folke/lazydev.nvim",  opts = {} },
	{ "b0o/schemastore.nvim" },
	{
		"MysticalDevil/inlay-hints.nvim",
		event = "LspAttach",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			require("inlay-hints").setup()
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			require("neoconf").setup()
			require("mason").setup()
			local lspconfig = require("lspconfig")
			local mason_lsp = require("mason-lspconfig")
			local mason_tool_install = require("mason-tool-installer")

			local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

			require("mason-null-ls").setup({
				ensure_installed = {},
				automatic_installation = true,
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
				},
				auto_update = true,
				run_on_start = true,
				integrations = {
					["mason-lspconfig"] = true,
					["mason-null-ls"] = true,
					["mason-nvim-dap"] = true,
				},
			})

			vim.lsp.inlay_hint.enable(true)

			local handlers = {
				-- Default handler
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = lsp_capabilities,
					})
				end,

				["lua_ls"] = function()
					lspconfig.lua_ls.setup({
						settings = require("plugins.lsp_lang_settings.lua_ls").settings,
					})
				end,

				["jsonls"] = function()
					lspconfig.jsonls.setup({
						settings = require("plugins.lsp_lang_settings.jsonls").settings,
					})
				end,

				["yamlls"] = function()
					lspconfig.yamlls.setup({
						settings = require("plugins.lsp_lang_settings.yamlls").settings,
					})
				end,

				["gopls"] = function()
					lspconfig.gopls.setup({
						settings = require("plugins.lsp_lang_settings.gopls").settings,
					})
				end,

				["ansiblels"] = function()
					lspconfig.ansiblels.setup({
						settings = require("plugins.lsp_lang_settings.ansible").settings,
					})
				end,
				["ts_ls"] = function()
					lspconfig.tsserver.setup({
						settings = require("plugins.lsp_lang_settings.typescript").settings,
					})
				end,
				["rust_analyzer"] = function()
					lspconfig.rust_analyzer.setup({
						settings = require("plugins.lsp_lang_settings.rust").settings,
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
				},
				severity_sort = true,
				float = {
					focusable = true,
					style = "minimal",
					border = "rounded",
					source = true,
					header = "",
					prefix = " ● ",
				},
				document_highlight = {
					enabled = true,
				},
				codelens = {
					enabled = false,
				},
			})
			vim.lsp.handlers["textDocument/publishDiagnostics"] =
			    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
				    -- Faster feedback but update less frequently
				    update_in_insert = false,
				    virtual_text = { spacing = 4, prefix = "●" },
			    })
		end,
	},
}
