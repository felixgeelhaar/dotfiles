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
			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
				vim.lsp.handlers.signature_help, {
					-- Disable automatic triggers
					border = "rounded",
					focusable = false,
					silent = true,
				}
			)

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
						capabilities = lsp_capabilities,
						settings = require("plugins.lsp_lang_settings.lua_ls").settings,
					})
				end,

				["jsonls"] = function()
					lspconfig.jsonls.setup({
						capabilities = lsp_capabilities,
						settings = require("plugins.lsp_lang_settings.jsonls").settings,
					})
				end,

				["yamlls"] = function()
					lspconfig.yamlls.setup({
						capabilities = lsp_capabilities,
						settings = require("plugins.lsp_lang_settings.yamlls").settings,
					})
				end,

				["gopls"] = function()
					lspconfig.gopls.setup({
						capabilities = lsp_capabilities,
						settings = require("plugins.lsp_lang_settings.gopls").settings,
					})
				end,

				["ansiblels"] = function()
					lspconfig.ansiblels.setup({
						capabilities = lsp_capabilities,
						settings = require("plugins.lsp_lang_settings.ansible").settings,
					})
				end,
				["ts_ls"] = function()
					lspconfig.ts_ls.setup({
						capabilities = lsp_capabilities,
						settings = require("plugins.lsp_lang_settings.typescript").settings,
						on_attach = function(client, bufnr)
							if client.server_capabilities and client.server_capabilities.signatureHelpProvider then
								client.server_capabilities.signatureHelpProvider.triggerCharacters = {}
							end
						end,
					})
				end,
				["rust_analyzer"] = function()
					lspconfig.rust_analyzer.setup({
						capabilities = lsp_capabilities,
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
			-- Optimize diagnostic handling (using modern API)
			vim.lsp.handlers["textDocument/publishDiagnostics"] =
				vim.lsp.with(vim.lsp.handlers["textDocument/publishDiagnostics"], {
					-- Reduce diagnostic frequency for better performance
					update_in_insert = false,
					virtual_text = { spacing = 4, prefix = "●" },
					-- Debounce diagnostics to reduce excessive updates
					debounce_text_changes = 200,
				})
			

			-- Enable native inlay hints (Neovim 0.10+)
			if vim.fn.has("nvim-0.10") == 1 then
				vim.lsp.inlay_hint.enable(true)
			end
		end,
	},
}
