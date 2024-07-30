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
	{ "b0o/schemastore.nvim" },
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
				ensure_installed = nil,
				automatic_installation = true,
			})

			mason_tool_install.setup({
				ensure_installed = {
					"lua_ls",
					"bashls",
					"gopls",
					"elixirls",
					"html",
					"tsserver",
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

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "go to definition" })
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "code action" })
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "go to declaration" })
			vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { desc = "go to implementation" })
			vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "signature help" })
			vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "rename" })
			vim.keymap.set("n", "<leader>xd", "<cmd>Telescope diagnostics theme=ivy<cr>", { desc = "diagnostics" })
			vim.keymap.set(
				"n",
				"gr",
				"<cmd>Telescope lsp_references theme=ivy path_display={'tail'}<cr>",
				{ desc = "go to references" }
			)
			vim.keymap.set(
				"n",
				"<leader>fr",
				"<cmd>Telescope lsp_references theme=ivy path_display={'tail'}<cr>",
				{ desc = "references" }
			)
		end,
	},
}
