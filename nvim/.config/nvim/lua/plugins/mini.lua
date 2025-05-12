return {
	{ "tpope/vim-sleuth" },
	{ "windwp/nvim-ts-autotag" },
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"hiphish/rainbow-delimiters.nvim",
		url = "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
		event = "BufReadPost",
		config = function()
			local rainbow_delimiters = require("rainbow-delimiters")
			vim.g.rainbow_delimiters = {
				strategy = {
					[""] = rainbow_delimiters.strategy["global"],
					vim = rainbow_delimiters.strategy["local"],
				},
				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
				},
			}
		end,
	},
	{
		"echasnovski/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			require("mini.ai").setup({ n_lines = 500 })
			require("mini.surround").setup()
			require("mini.misc").setup()
			require("mini.icons").setup({
				init = function()
					package.preload["nvim-web-devicons"] = function()
						require("mini.icons").mock_nvim_web_devicons()
						return package.loaded["nvim-web-devicons"]
					end
				end,
			})
			require("mini.pairs").setup({
				modes = { insert = true, command = true, terminal = false },
				skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
				skip_ts = { "string" },
				skip_unbalanced = true,
				markdown = true,
			})
			require("mini.splitjoin").setup()
			require("mini.colors").setup()
			require("mini.move").setup({
				mappings = {
					-- Move visual selection in Visual mode
					left = "<C-H>",
					right = "<C-L>",
					down = "<C-J>",
					up = "<C-K>",
				},
			})
		end,
	},
	{
		"echasnovski/mini.hipatterns",
		event = "BufReadPre",
		opts = function()
			local hi = require("mini.hipatterns")
			return {
				tailwind = {
					enabled = true,
					ft = {
						"astro",
						"css",
						"heex",
						"html",
						"html-eex",
						"javascript",
						"javascriptreact",
						"rust",
						"svelte",
						"typescript",
						"typescriptreact",
						"vue",
					},
					style = "compact",
				},
				highlighters = {
					warn = { pattern = "%f[%w]()WARN()%f[%W]", group = "MiniHipatternsHack" },
					fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
					error = { pattern = "%f[%w]()ERROR()%f[%W]", group = "MiniHipatternsFixme" },
					todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
					note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
					hex_color = hi.gen_highlighter.hex_color({ priority = 2000 }),
					shorthand = {
						pattern = "()#%x%x%x()%f[^%x%w]",
						group = function(_, _, data)
							---@type string
							local match = data.full_match
							local r, g, b = match:sub(2, 2), match:sub(3, 3), match:sub(4, 4)
							local hex_color = "#" .. r .. r .. g .. g .. b .. b
							return hi.compute_hex_color_group(hex_color, "bg")
						end,
						extmark_opts = { priority = 2000 },
					},
				},
			}
		end,
		config = function(_, opts)
			require("mini.hipatterns").setup(opts)
		end,
	},
}
