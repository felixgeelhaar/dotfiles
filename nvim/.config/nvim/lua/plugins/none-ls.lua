return {
	"nvimtools/none-ls.nvim",
	event = { "BufReadPre", "BufNewFile" }, -- Lazy load on buffer events
	dependencies = {
		"mason.nvim",
		"nvim-lua/plenary.nvim",
		"nvimtools/none-ls-extras.nvim",
		"gwinn/none-ls-jsonlint.nvim",
	},
	config = function()
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		local none_ls = require("null-ls")

		-- Function to conditionally enable sources based on available executables
		local function get_available_sources()
			local sources = {}

			-- Helper to check if command exists and add source if it does
			local function add_if_available(command, source)
				if vim.fn.executable(command) == 1 then
					table.insert(sources, source)
				end
			end

			-- Code actions (always add as they're evaluated when needed)
			table.insert(sources, none_ls.builtins.code_actions.gomodifytags)
			table.insert(sources, none_ls.builtins.code_actions.impl)

			-- Formatting
			add_if_available("stylua", none_ls.builtins.formatting.stylua)
			add_if_available("prettier", none_ls.builtins.formatting.prettier)
			add_if_available("biome", none_ls.builtins.formatting.biome)
			add_if_available("htmlbeautifier", none_ls.builtins.formatting.htmlbeautifier)
			add_if_available("rustywind", none_ls.builtins.formatting.rustywind)
			add_if_available("black", none_ls.builtins.formatting.black)
			add_if_available("isort", none_ls.builtins.formatting.isort)
			add_if_available("gofmt", none_ls.builtins.formatting.gofmt)
			add_if_available("gofumpt", none_ls.builtins.formatting.gofumpt)
			add_if_available("goimports", none_ls.builtins.formatting.goimports)
			add_if_available("golines", none_ls.builtins.formatting.golines)
			add_if_available("rustfmt", require("none-ls.formatting.rustfmt"))
			add_if_available("protolint", none_ls.builtins.formatting.protolint)
			add_if_available("shfmt", none_ls.builtins.formatting.shfmt)
			add_if_available("yamlfmt", none_ls.builtins.formatting.yamlfmt)
			add_if_available("markdownlint", none_ls.builtins.formatting.markdownlint)

			-- Diagnostics
			add_if_available("stylelint", none_ls.builtins.diagnostics.stylelint)
			add_if_available("pylint", none_ls.builtins.diagnostics.pylint)
			add_if_available("tidy", none_ls.builtins.diagnostics.tidy)
			add_if_available("markdownlint", none_ls.builtins.diagnostics.markdownlint)
			add_if_available("vale", none_ls.builtins.diagnostics.vale)
			add_if_available("golangci-lint", none_ls.builtins.diagnostics.golangci_lint)
			add_if_available("codespell", none_ls.builtins.diagnostics.codespell)
			add_if_available("jsonlint", require("none-ls-jsonlint.diagnostics.jsonlint"))
			add_if_available("yamllint", none_ls.builtins.diagnostics.yamllint)
			add_if_available("zsh", none_ls.builtins.diagnostics.zsh)
			add_if_available("ansible-lint", none_ls.builtins.diagnostics.ansiblelint)

			return sources
		end

		none_ls.setup({
			sources = get_available_sources(),
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({
						group = augroup,
						buffer = bufnr,
					})
					-- Add a user command to toggle format on save
					vim.api.nvim_create_user_command("ToggleFormatOnSave", function()
						if vim.b.format_on_save then
							vim.b.format_on_save = false
							vim.notify("Format on save disabled", "info",
								{ title = "Formatting" })
						else
							vim.b.format_on_save = true
							vim.notify("Format on save enabled", "info",
								{ title = "Formatting" })
						end
					end, {})

					-- Only format on save if enabled (default to true)
					if vim.b.format_on_save ~= false then
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								if vim.b.format_on_save ~= false then
									vim.lsp.buf.format({ bufnr = bufnr })
								end
							end,
						})
					end
				end
			end,
		})

		-- Remove this keymap as it's already defined in your centralized keymaps
		-- vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format buffer" })
		vim.keymap.set("n", "<leader>cF", "<cmd>ToggleFormatOnSave<CR>", { desc = "Toggle Format on Save" })
	end,
}
