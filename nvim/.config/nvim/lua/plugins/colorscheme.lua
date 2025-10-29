-- Rose Pine Moon Theme (Active)
return {
  "rose-pine/neovim",
  name = "rose-pine",
  lazy = false, -- Load immediately for consistent appearance
  priority = 1000, -- Load before other plugins
  opts = {
    variant = "moon", -- moon (darker), main, dawn
    dark_variant = "moon",
    disable_background = true, -- Transparent background
    disable_float_background = false,
    disable_italics = false,

    -- Highlight groups
    highlight_groups = {
      -- Completion menu
      Pmenu = { bg = "surface" },
      PmenuSel = { bg = "pine", fg = "base" },

      -- Floating windows
      NormalFloat = { bg = "surface" },
      FloatBorder = { bg = "surface", fg = "muted" },

      -- Telescope
      TelescopeNormal = { bg = "surface" },
      TelescopePromptPrefix = { fg = "foam" },
      TelescopeSelection = { bg = "overlay", fg = "text" },
      TelescopeMatching = { fg = "rose" },
      TelescopeSelectionCaret = { fg = "rose" },

      -- Git signs
      GitSignsChange = { fg = "foam" },

      -- LazyGit
      LazyGitFloat = { bg = "base" },
      LazyGitBorder = { fg = "muted" },
    },
  },
  config = function(_, opts)
    require("rose-pine").setup(opts)
    vim.cmd("colorscheme rose-pine-moon")
  end,
}

-- ============================================================================
-- ALTERNATIVE THEME: Catppuccin Macchiato (Commented Out)
-- ============================================================================
-- To switch back to Catppuccin:
-- 1. Comment out the Rose Pine configuration above (lines 2-41)
-- 2. Uncomment the Catppuccin configuration below
--
-- return {
-- 	"catppuccin/nvim",
-- 	name = "catppuccin",
-- 	lazy = false,
-- 	priority = 1000,
-- 	opts = {
-- 		flavour = "macchiato", -- "latte, frappe, macchiato, mocha"
-- 		background = {
-- 			dark = "macchiato",
-- 		},
-- 		transparent_background = true,
-- 		integrations = {
-- 			alpha = true,
-- 			blink_cmp = true,
-- 			dap = true,
-- 			dap_ui = true,
-- 			fidget = true,
-- 			gitsigns = true,
-- 			harpoon = true,
-- 			overseer = true,
-- 			markdown = true,
-- 			mason = true,
-- 			mini = {
-- 				enabled = true,
-- 				indentscope_color = "surface2",
-- 			},
-- 			neotree = true,
-- 			neotest = true,
-- 			native_lsp = {
-- 				enabled = true,
-- 				underlines = {
-- 					errors = { "undercurl" },
-- 					hints = { "undercurl" },
-- 					warnings = { "undercurl" },
-- 					information = { "undercurl" },
-- 				},
-- 				inlay_hints = {
-- 					background = true,
-- 				},
-- 			},
-- 			notify = true,
-- 			treesitter = true,
-- 			treesitter_context = true,
-- 			rainbow_delimiters = true,
-- 			semantic_tokens = true,
-- 			telescope = {
-- 				enabled = true,
-- 			},
-- 			which_key = true,
-- 		},
-- 		custom_highlights = function(colors)
-- 			return {
-- 				Pmenu = { bg = colors.surface0 },
-- 				PmenuSel = { bg = colors.blue, fg = colors.base },
-- 				NormalFloat = { bg = colors.surface0 },
-- 				FloatBorder = { bg = colors.surface0 },
-- 				TelescopeNormal = { bg = colors.surface0 },
-- 				TelescopePromptPrefix = { fg = colors.blue },
-- 				TelescopeSelection = { bg = colors.surface1, fg = colors.text },
-- 				TelescopeMatching = { fg = colors.blue },
-- 				TelescopeSelectionCaret = { fg = colors.blue },
-- 				GitSignsChange = { fg = colors.blue },
-- 				LazyGitFloat = { bg = colors.mantle },
-- 				LazyGitBorder = { fg = colors.mantle },
-- 			}
-- 		end,
-- 	},
-- 	config = function(_, opts)
-- 		require("catppuccin").setup(opts)
-- 		vim.cmd("colorscheme catppuccin")
-- 	end,
-- }
