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
			require("mini.pairs").setup({
				modes = { insert = true, command = true, terminal = false },
				skip_next = [=[[%w%%%'%[%"%.%`%$]]=], -- skip autopair when next character is one of these
				skip_ts = { "string" }, -- skip autopair when the cursor is inside these treesitter nodes
				skip_unbalanced = true, -- skip autopair when next character is closing pair and there are more closing pairs than opening pairs
				markdown = true, -- better deal with markdown code blocks
			})
			require("mini.splitjoin").setup()
			require("mini.move").setup()

			-- Simple and easy statusline.
			local statusline = require("mini.statusline")
			statusline.setup()

			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function()
				return ""
			end

			-- You can navigate selections
			require("mini.move").setup({
				mappings = {
					-- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
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
		recommended = true,
		desc = "Highlight colors in your code.",
		opts = function()
			local hi = require("mini.hipatterns")
			return {
				-- custom LazyVim option to enable the tailwind integration
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
		-- config = function(_, opts)
		--   if type(opts.tailwind) == 'table' and opts.tailwind.enabled then
		--     -- reset hl groups when colorscheme changes
		--     vim.api.nvim_create_autocmd('ColorScheme', {
		--       callback = function()
		--         M.hl = {}
		--       end,
		--     })
		--     opts.highlighters.tailwind = {
		--       pattern = function()
		--         if not vim.tbl_contains(opts.tailwind.ft, vim.bo.filetype) then
		--           return
		--         end
		--         if opts.tailwind.style == 'full' then
		--           return '%f[%w:-]()[%w:-]+%-[a-z%-]+%-%d+()%f[^%w:-]'
		--         elseif opts.tailwind.style == 'compact' then
		--           return '%f[%w:-][%w:-]+%-()[a-z%-]+%-%d+()%f[^%w:-]'
		--         end
		--       end,
		--       group = function(_, _, m)
		--         ---@type string
		--         local match = m.full_match
		--         ---@type string, number
		--         local color, shade = match:match '[%w-]+%-([a-z%-]+)%-(%d+)'
		--         shade = tonumber(shade)
		--         local bg = vim.tbl_get(M.colors, color, shade)
		--         if bg then
		--           local hl = 'MiniHipatternsTailwind' .. color .. shade
		--           if not M.hl[hl] then
		--             M.hl[hl] = true
		--             local bg_shade = shade == 500 and 950 or shade < 500 and 900 or 100
		--             local fg = vim.tbl_get(M.colors, color, bg_shade)
		--             vim.api.nvim_set_hl(0, hl, { bg = '#' .. bg, fg = '#' .. fg })
		--           end
		--           return hl
		--         end
		--       end,
		--       extmark_opts = { priority = 2000 },
		--     }
		--   end
		--   require('mini.hipatterns').setup(opts)
		-- end,
	},
}
