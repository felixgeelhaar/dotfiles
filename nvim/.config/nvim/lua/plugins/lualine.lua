return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons", "bwpge/lualine-pretty-path" },
		init = function()
			vim.g.lualine_laststatus = vim.o.laststatus
			if vim.fn.argc(-1) > 0 then
				-- set an empty statusline till lualine loads
				vim.o.statusline = " "
			else
				-- hide the statusline on the starter page
				vim.o.laststatus = 0
			end
		end,
		opts = function()
			local lualine_require = require("lualine_require")
			lualine_require.require = require

			-- local icons = Configs.icons
			-- vim.o.laststatus = vim.g.lualine_laststatus
			vim.o.laststatus = 3
			local icons = {
				misc = {
					dots = "󰇘",
				},
				ft = {
					octo = "",
				},
				dap = {
					Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
					Breakpoint = " ",
					BreakpointCondition = " ",
					BreakpointRejected = { " ", "DiagnosticError" },
					LogPoint = ".>",
				},
				diagnostics = {
					Error = " ",
					Warn = " ",
					Hint = " ",
					Info = " ",
				},
				git = {
					added = " ",
					modified = " ",
					removed = " ",
				},
				kinds = {
					Array = " ",
					Boolean = "󰨙 ",
					Class = " ",
					Codeium = "󰘦 ",
					Color = " ",
					Control = " ",
					Collapsed = " ",
					Constant = "󰏿 ",
					Constructor = " ",
					Copilot = " ",
					Enum = " ",
					EnumMember = " ",
					Event = " ",
					Field = " ",
					File = " ",
					Folder = " ",
					Function = "󰊕 ",
					Interface = " ",
					Key = " ",
					Keyword = " ",
					Method = "󰊕 ",
					Module = " ",
					Namespace = "󰦮 ",
					Null = " ",
					Number = "󰎠 ",
					Object = " ",
					Operator = " ",
					Package = " ",
					Property = " ",
					Reference = " ",
					Snippet = " ",
					String = " ",
					Struct = "󰆼 ",
					TabNine = "󰏚 ",
					Text = " ",
					TypeParameter = " ",
					Unit = " ",
					Value = " ",
					Variable = "󰀫 ",
				},
			}

			local opts = {
				icons_enabled = true,
				theme = "auto",
				globalstatus = vim.o.laststatus == 3,
				disabled_filetypes = {
					statusline = { "dashboard", "alpha", "ministarter" },
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},

				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch" },
					lualine_c = {
						"filename",
						{
							"diagnostics",
							symbols = {
								error = icons.diagnostics.Error,
								warn = icons.diagnostics.Warn,
								info = icons.diagnostics.Info,
								hint = icons.diagnostics.Hint,
							},
						},
						{
							"filetype",
							icon_only = true,
							separator = "",
							padding = { left = 1, right = 0 },
						},
						{
							"pretty-path",
						},
					},
					lualine_x = {
						{
							function()
								return require("noice").api.status.command.get()
							end,
							cond = function()
								return package.loaded["noice"] and require("noice").api.status.command.has()
							end,
							-- color = function()
							-- 	return LazyVim.ui.fg("Statement")
							-- end,
						},
						{
							function()
								return require("noice").api.status.mode.get()
							end,
							cond = function()
								return package.loaded["noice"] and require("noice").api.status.mode.has()
							end,
							-- color = function() return LazyVim.ui.fg("Constant") end,
						},
						{
							function()
								return "  " .. require("dap").status()
							end,
							cond = function()
								return package.loaded["dap"] and require("dap").status() ~= ""
							end,
							-- color = function() return LazyVim.ui.fg("Debug") end,
						},
						{
							require("lazy.status").updates,
							cond = require("lazy.status").has_updates,
							-- color = function() return LazyVim.ui.fg("Special") end,
						},
						{
							"diff",
							symbols = {
								added = icons.git.added,
								modified = icons.git.modified,
								removed = icons.git.removed,
							},
							source = function()
								local gitsigns = vim.b.gitsigns_status_dict
								if gitsigns then
									return {
										added = gitsigns.added,
										modified = gitsigns.changed,
										removed = gitsigns.removed,
									}
								end
							end,
						},
					},
					lualine_y = {
						{ "progress", separator = " ", padding = { left = 1, right = 0 } },
						{ "location", padding = { left = 0, right = 1 } },
					},
					lualine_z = {
						function()
							return " " .. os.date("%R")
						end,
					},
				},
				extensions = { "neo-tree", "lazy" },
			}
			if vim.g.trouble_lualine then
				local trouble = require("trouble")
				local symbols = trouble.statusline({
					mode = "symbols",
					groups = {},
					title = false,
					filter = { range = true },
					format = "{kind_icon}{symbol.name:Normal}",
					hl_group = "lualine_c_normal",
				})
				table.insert(opts.sections.lualine_c, {
					symbols and symbols.get,
					cond = function()
						return vim.b.trouble_lualine ~= false and symbols.has()
					end,
				})
			end
			return opts
		end,
	},
}
-- { "nvim-lualine/lualine.nvim",
-- 		event = "VeryLazy",
-- 		dependencies = {
-- 			"nvim-tree/nvim-web-devicons",
-- 			"bwpge/lualine-pretty-path",
-- 		},
-- 		init = function()
-- 			vim.g.lualine_laststatus = vim.o.laststatus
-- 			if vim.fn.argc(-1) > 0 then
-- 				-- set an empty statusline till lualine loads
-- 				vim.o.statusline = " "
-- 			else
-- 				-- hide the statusline on the starter page
-- 				vim.o.laststatus = 0
-- 			end
-- 		end,
-- 		opts = function()
-- 			-- PERF: we don't need this lualine require madness 🤷
-- 			local lualine_require = require("lualine_require")
-- 			lualine_require.require = require
--
-- 			-- local icons = require("nvim-web-devicons")
-- 			local colors = require("mini.colors").get_colorscheme()
-- 			vim.o.laststatus = vim.g.lualine_laststatus
--
-- 			print("Loading lualine", colors)
--
-- 			local opts = {
-- 				options = {
-- 					theme = "auto",
-- 					globalstatus = vim.o.laststatus == 3,
-- 					disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter" } },
-- 				},
-- 				sections = {
-- 					lualine_a = { "mode" },
-- 					lualine_b = { "branch" },
--
-- 					-- lualine_c = {
-- 					-- 	vim.fn.getcwd()({
-- 					-- 		"diagnostics",
-- 					-- 		symbols = {
-- 					-- 			error = icons.get_icon("diagnostics", "Error"),
-- 					-- 			warn = icons.diagnostics.Warn,
-- 					-- 			info = icons.diagnostics.Info,
-- 					-- 			hint = icons.diagnostics.Hint,
-- 					-- 		},
-- 					-- 	}),
-- 					-- 	{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
-- 					-- 	{ "pretty-path" },
-- 					-- },
-- 					lualine_x = {
-- 						{
-- 							function()
-- 								return require("noice").api.status.command.get()
-- 							end,
-- 							cond = function()
-- 								return package.loaded["noice"] and require("noice").api.status.command.has()
-- 							end,
-- 							color = function()
-- 								return colors("Statement")
-- 							end,
-- 						},
-- 						{
-- 							function()
-- 								return require("noice").api.status.mode.get()
-- 							end,
-- 							cond = function()
-- 								return package.loaded["noice"] and require("noice").api.status.mode.has()
-- 							end,
-- 							color = function()
-- 								return colors.fg("Constant")
-- 							end,
-- 						},
-- 						{
-- 							function()
-- 								return "  " .. require("dap").status()
-- 							end,
-- 							cond = function()
-- 								return package.loaded["dap"] and require("dap").status() ~= ""
-- 							end,
-- 							color = function()
-- 								return colors.fg("Debug")
-- 							end,
-- 						},
-- 						{
-- 							require("lazy.status").updates,
-- 							cond = require("lazy.status").has_updates,
-- 							color = function()
-- 								return colors.fg("Special")
-- 							end,
-- 						},
-- 						-- {
-- 						-- 	"diff",
-- 						-- 	symbols = {
-- 						-- 		added = icons.git.added,
-- 						-- 		modified = icons.git.modified,
-- 						-- 		removed = icons.git.removed,
-- 						-- 	},
-- 						-- 	source = function()
-- 						-- 		local gitsigns = vim.b.gitsigns_status_dict
-- 						-- 		if gitsigns then
-- 						-- 			return {
-- 						-- 				added = gitsigns.added,
-- 						-- 				modified = gitsigns.changed,
-- 						-- 				removed = gitsigns.removed,
-- 						-- 			}
-- 						-- 		end
-- 						-- 	end,
-- 						-- },
-- 					},
-- 					lualine_y = {
-- 						{ "progress", separator = " ", padding = { left = 1, right = 0 } },
-- 						{ "location", padding = { left = 0, right = 1 } },
-- 					},
-- 					lualine_z = {
-- 						function()
-- 							return " " .. os.date("%R")
-- 						end,
-- 					},
-- 				},
-- 				extensions = { "neo-tree", "lazy" },
-- 			}
--
-- 			if vim.g.trouble_lualine then
-- 				local trouble = require("trouble")
-- 				local symbols = trouble.statusline({
-- 					mode = "symbols",
-- 					groups = {},
-- 					title = false,
-- 					filter = { range = true },
-- 					format = "{kind_icon}{symbol.name:Normal}",
-- 					hl_group = "lualine_c_normal",
-- 				})
-- 				table.insert(opts.sections.lualine_c, {
-- 					symbols and symbols.get,
-- 					cond = function()
-- 						return vim.b.trouble_lualine ~= false and symbols.has()
-- 					end,
-- 				})
-- 			end
--
-- 			return opts
-- 		end,
-- 	},
