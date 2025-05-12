return {
	"kdheepak/lazygit.nvim",
	-- optional for floating window border decoration
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	cmd = {
		"LazyGit",
		"LazyGitConfig",
		"LazyGitCurrentFile",
		"LazyGitFilter",
		"LazyGitFilterCurrentFile",
	},
	keys = {
		{ "<leader>gg", "<cmd>LazyGit<CR>", desc = "LazyGit" },
	},
	-- opts = {
	-- -- your configuration comes here
	-- -- or leave it empty to use the default settings
	-- -- refer to the configuration section below
	-- },
	-- setup = function() end,
}
