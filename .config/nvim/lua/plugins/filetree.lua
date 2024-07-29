return {
	"nvim-neo-tree/neo-tree.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			close_if_last_window = true,
			popup_border_style = "rounded",
			filesystem = {
				follow_current_file = { enabled = true },
			},
			enable_git_status = true,
			enable_diagnostics = true,
			default_component_configs = {
				indent = {
					with_markers = false,
					with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
				modified = {
					symbol = "󰐗",
				},
				git_status = {
					symbols = {
						modified = "",
						untracked = "",
						ignored = "",
						unstaged = "",
						staged = "",
						conflict = "",
					},
				},
			},
			-- event_handlers = {
			{
				event = "file_opened",
				handler = function(_)
					require("neo-tree.command").execute({ action = "close" }) -- auto close
				end,
			},
			vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "explorer (toggle)" }),
			vim.keymap.set("n", "<leader>ge", "<cmd>Neotree git_status toggle<CR>", { desc = "status explorer" }),
		})
	end,
}
