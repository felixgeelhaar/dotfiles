return {
	"nvimtools/none-ls.nvim",
	-- event = "LazyFile",
	dependencies = {
		"mason.nvim",
		"nvim-lua/plenary.nvim",
		"nvimtools/none-ls-extras.nvim",
		"gwinn/none-ls-jsonlint.nvim",
	},
	config = function()
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		local none_ls = require("null-ls")

		none_ls.setup({
			sources = {
				-- Code actions
				-- Go tool to modify struct field tags
				none_ls.builtins.code_actions.gomodifytags,
				-- impl generates method stubs for implementing an interface.
				none_ls.builtins.code_actions.impl,
				-- Formatting
				-- An opinionated code formatter for Lua.
				none_ls.builtins.formatting.stylua,
				-- Prettier is an opinionated code formatter. It enforces a consistent style by parsing your code and re-printing it with its own rules that take the maximum line length into account, wrapping code when necessary.
				none_ls.builtins.formatting.prettier,
				-- Formatter, linter, bundler, and more for JavaScript, TypeScript, JSON, HTML, Markdown, and CSS.
				none_ls.builtins.formatting.biome,
				-- A normaliser/beautifier for HTML that also understands embedded Ruby. Ideal for tidying up Rails templates.
				none_ls.builtins.formatting.htmlbeautifier,
				-- CLI for organizing Tailwind CSS classes.
				none_ls.builtins.formatting.rustywind,
				-- The uncompromising Python code formatter
				none_ls.builtins.formatting.black,
				-- Python utility / library to sort imports alphabetically and automatically separate them into sections and by type.
				none_ls.builtins.formatting.isort,
				-- Formats go programs.
				none_ls.builtins.formatting.gofmt,
				-- Enforce a stricter format than gofmt, while being backwards compatible. That is, gofumpt is happy with a subset of the formats that gofmt is happy with.
				none_ls.builtins.formatting.gofumpt,
				-- Updates your Go import lines, adding missing ones and removing unreferenced ones.
				none_ls.builtins.formatting.goimports,
				-- Applies a base formatter (eg. goimports or gofmt), then shortens long lines of code.
				none_ls.builtins.formatting.golines,
				-- Formats Rust programs.
				require("none-ls.formatting.rustfmt"),
				-- Fix common misspellings in text files.
				none_ls.builtins.formatting.codespell,
				-- A pluggable linter and fixer to enforce Protocol Buffer style and conventions.
				none_ls.builtins.formatting.protolint,
				-- A shell parser, formatter, and interpreter with bash support.
				none_ls.builtins.formatting.shfmt,
				-- A configurable YAML formatter that keeps comments.
				none_ls.builtins.formatting.yamlfmt,
				-- A Node.js style checker and lint tool for Markdown/CommonMark files.
				none_ls.builtins.formatting.markdownlint,
				-- A mighty, modern linter that helps you avoid errors and enforce conventions in your styles.
				none_ls.builtins.diagnostics.stylelint,
				-- Pylint is a Python static code analysis tool which looks for programming errors, helps enforcing a coding standard, sniffs for code smells and offers simple refactoring suggestions.
				none_ls.builtins.diagnostics.pylint,
				-- Tidy corrects and cleans up HTML and XML documents by fixing markup errors and upgrading legacy code to modern standards.
				none_ls.builtins.diagnostics.tidy,
				-- Markdown style and syntax checker.
				none_ls.builtins.diagnostics.markdownlint,
				-- Syntax-aware linter for prose built with speed and extensibility in mind.
				none_ls.builtins.diagnostics.vale,
				-- A Go linter aggregator.
				none_ls.builtins.diagnostics.golangci_lint,
				-- Lightning-fast linter for .env files.
				none_ls.builtins.diagnostics.dotenv_linter,
				-- Codespell finds common misspellings in text files.
				none_ls.builtins.diagnostics.codespell,
				-- A linter for JSON files.
				require("none-ls-jsonlint.diagnostics.jsonlint"),
				-- A linter for YAML files.
				none_ls.builtins.diagnostics.yamllint,
				-- Uses zsh's own -n option to evaluate, but not execute, zsh scripts. Effectively, this acts somewhat like a linter, although it only really checks for serious errors - and will likely only show the first error.
				none_ls.builtins.diagnostics.zsh,
				-- Linter for Ansible playbooks, roles and collections.
				none_ls.builtins.diagnostics.ansiblelint,
			},
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({
						group = augroup,
						buffer = bufnr,
					})
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr })
						end,
					})
				end
			end,
		})

		vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, {})
	end,
}
