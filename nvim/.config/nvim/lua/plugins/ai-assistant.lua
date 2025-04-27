return {
	"olimorris/codecompanion.nvim",
	opts = {},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"github/copilot.vim",
	},
	config = function(_, opts)
		require("codecompanion").setup({
			adapters = {
				copilot = function()
					return require("codecompanion.adapters").extend("copilot", {
						schema = {
							model = {
								default = "claude-3.7-sonnet",
							},
						},
					})
				end,
			},
			display = {
				action_palette = {
					width = 95,
					height = 10,
					prompt = "Prompt ", -- Prompt used for interactive LLM calls
					provider = "telescope", -- Can be "default", "telescope", or "mini_pick". If not specified, the plugin will autodetect installed providers.
					opts = {
						show_default_actions = true, -- Show the default actions in the action palette?
						show_default_prompt_library = true, -- Show the default prompt library in the action palette?
					},
				},
			},
			keymaps = {
				{ "n", "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true } },
				{ "n", "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true } },
				{ "v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true } },
			},
		})
	end,
}
