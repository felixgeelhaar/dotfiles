return {
	{
		"folke/noice.nvim",
		lazy = false, -- Load immediately, not lazily
		priority = 1000, -- Load with high priority
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		opts = {
			-- Enable LSP overrides
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			-- Enable presets for modern UI
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = false,
			},
			-- Ensure all messages go through noice
			messages = {
				enabled = true, -- enables the Noice messages UI
				view = "notify", -- default view for messages
				view_error = "notify", -- view for errors
				view_warn = "notify", -- view for warnings
				view_history = "messages", -- view for :messages
				view_search = "virtualtext", -- view for search count messages
			},
			-- Route specific message patterns and filter out only specific noisy messages
			routes = {
				{
					view = "notify",
					filter = { event = "msg_showmode" },
				},
				-- Filter out only specific timeout warnings, not all messages
				{
					filter = {
						event = "notify",
						any = {
							{ find = "Formatter.*timeout" },
							{ find = "%[LSP%].*timeout" },
						},
					},
					opts = { skip = true },
				},
				-- Ensure save messages go through noice
				{
					filter = { event = "msg_show", kind = "bufwrite" },
					view = "notify",
				},
			},
		},
		config = function(_, opts)
			require("noice").setup(opts)
		end,
	},
}
