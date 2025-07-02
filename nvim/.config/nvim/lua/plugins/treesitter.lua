return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" }, -- Lazy load for better startup
		config = function()
			-- Use the recommended API to setup modules
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"bash",
					"go",
					"astro",
					"gomod",
					"gosum",
					"gowork",
					"html",
					"json",
					"lua",
					"markdown",
					"markdown_inline",
					"python",
					"rust",
					"typescript",
					"javascript",
					"sql",
					"toml",
					"yaml",
					"regex",
					"css",
					"dockerfile",
					"gitignore",
					"vim",
					"vimdoc",
					"query", -- Add these useful ones
				},

				-- Module configuration
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},

				indent = {
					enable = true,
				},

				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},

				textobjects = {
					move = {
						enable = true,
						goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
						goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
						goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
						goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
					},
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
							["ii"] = "@conditional.inner",
							["ai"] = "@conditional.outer",
							["il"] = "@loop.inner",
							["al"] = "@loop.outer",
							["at"] = "@comment.outer",
						},
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>cpa"] = "@parameter.inner", -- cp = code parameter
						},
						swap_previous = {
							["<leader>cpA"] = "@parameter.inner", -- cp = code parameter
						},
					},
				},

				-- Auto-install additional parsers
				auto_install = true,

				-- Improve folding using treesitter
				fold = {
					enable = true,
				},

				-- Enable autotag for HTML tags
				autotag = {
					enable = true,
				},
			})

			-- Setup folding
			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
			vim.opt.foldenable = false -- Start with folds open
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "VeryLazy",
		enabled = true,
		opts = {
			mode = "cursor",
			max_lines = 3, -- Show more context (up from 1)
			min_window_height = 10,
			trim_scope = "outer",
		},
	},
}
