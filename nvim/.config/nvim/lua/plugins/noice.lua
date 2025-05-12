return {
	{
		"folke/noice.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
			-- Add telescope dependency for proper Telescope integration
			"nvim-telescope/telescope.nvim",
		},
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
				hover = {
					enabled = true,
					view = nil, -- Use default view
					border = "rounded",
				},
				signature = {
					enabled = true,
					auto_open = {
						enabled = true,
						trigger = true,
						luasnip = true,
						throttle = 50,
					},
				},
			},
			routes = {
				-- Filter out annoying messages
				{
					filter = {
						event = "msg_show",
						any = {
							{ find = "%d+L, %d+B" },
							{ find = "; after #%d+" },
							{ find = "; before #%d+" },
						},
					},
					view = "mini", -- Use mini view instead of notify
				},
				-- Routing notifications to nvim-notify
				{
					filter = {
						event = "notify",
						min_height = 10,
					},
					view = "split", -- Route to split when message is long
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = true, -- Incremental renaming UI
			},
			cmdline = {
				enabled = true,
				view = "cmdline_popup",
			},
			views = {
				cmdline_popup = {
					position = {
						row = 5,
						col = "50%",
					},
					size = {
						width = "auto",
						height = "auto",
					},
					border = {
						style = "rounded",
						padding = { 0, 1 },
					},
				},
				popupmenu = {
					relative = "editor",
					position = {
						row = 8,
						col = "50%",
					},
					size = {
						width = 60,
						height = 10,
					},
					border = {
						style = "rounded",
						padding = { 0, 1 },
					},
					win_options = {
						winhighlight = { Normal = "Normal", FloatBorder = "NoiceCmdlinePopupBorder" },
					},
				},
				-- Configure the history view
				history = {
					-- View for the history
					view = "split",
					opts = { enter = true },
					filter = { event = { "msg_show", "notify" } },
				},
				-- Configure the Noice telescope extension
				telescope = {
					position = {
						row = "50%",
						col = "50%",
					},
					size = {
						width = 120,
						height = 25,
					},
				},
			},
			-- Set up Telescope integration
			commands = {
				history = {
					view = "split",
					opts = { enter = true },
					filter = { event = { "msg_show", "notify" } },
				},
				last = {
					view = "popup",
					opts = { enter = true },
					filter = { event = { "msg_show", "notify" } },
					filter_opts = { count = 1 },
				},
			},
		},
		config = function(_, opts)
			-- HACK: noice shows messages from before it was enabled,
			-- but this is not ideal when Lazy is installing plugins,
			-- so clear the messages in this case.
			if vim.o.filetype == "lazy" then
				vim.cmd([[messages clear]])
			end
			require("noice").setup(opts)

			-- Set up the telescope extension
			require("telescope").load_extension("noice")
		end,
	},
}
