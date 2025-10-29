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

			-- Note: All formatting is handled by conform.nvim to avoid conflicts

			-- Diagnostics
			add_if_available("stylelint", none_ls.builtins.diagnostics.stylelint)
			add_if_available("pylint", none_ls.builtins.diagnostics.pylint)
			add_if_available("tidy", none_ls.builtins.diagnostics.tidy)
			add_if_available("markdownlint", none_ls.builtins.diagnostics.markdownlint)
			-- Vale with config file check
			if vim.fn.executable("vale") == 1 then
				-- Check if Vale has a config file in current directory or home directory
				local config_paths = { ".vale.ini", ".vale.yaml", ".vale.json", vim.fn.expand("~/.vale.ini") }
				local has_config = false
				for _, path in ipairs(config_paths) do
					if vim.fn.filereadable(path) == 1 then
						has_config = true
						break
					end
				end
				if has_config then
					table.insert(sources, none_ls.builtins.diagnostics.vale)
				end
			end
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
				-- Note: Format on save is handled by conform.nvim to avoid conflicts
				-- none-ls provides diagnostics and code actions, not formatting on save
			end,
		})

		-- Format keymaps are handled by conform.nvim in its configuration
	end,
}
