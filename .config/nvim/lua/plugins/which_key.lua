return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			local wk = require("which-key")
			local MiniIcons = require("mini.icons")

			wk.setup({
				preset = "modern",
				spec = {
					{ "<leader>c", group = "[C]ode", icon = { icon = MiniIcons.get("directory", "src") } },
					{ "<leader>l", group = "[L]azy", icon = { icon = MiniIcons.get("filetype", "lazy") } },
					{ "<leader>t", group = "[T]est", icon = { icon = MiniIcons.get("directory", "test") } },
					{ "<leader>a", group = "[A]ction", icon = { icon = MiniIcons.get("directory", ".github") } },
					{ "<leader>b", group = "[B]uffer", icon = { icon = MiniIcons.get("filetype", "Readme.md") } },
					{ "<leader>d", group = "[D]ebug", icon = { icon = MiniIcons.get("lsp", "class") } },
					{ "<leader>f", group = "[F]ile", icon = { icon = MiniIcons.get("lsp", "file") } },
					{ "<leader>g", group = "[G]it", icon = { icon = MiniIcons.get("filetype", ".git") } },
					{ "<leader>x", group = "quickfi[X]", icon = { icon = MiniIcons.get("filetype", "mason") } },
					{ "<leader>o", group = "[O]verseer", icon = { icon = MiniIcons.get("directory", "build") } },
					{ "<leader>n", group = "[N]oice", icon = { icon = MiniIcons.get("file", "Changelog") } },
				},
				win = {
					title = false,
				},
				icons = {
					rules = false,
				},
			})
		end,
	},
}
