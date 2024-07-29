-- -- Catppuccin Theme
return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  opts = {
    flavour = "mocha", -- "latte, frappe, macchiato, mocha"
    background = {
      dark = "mocha",
    },
    transparent_background = true,
    integrations = {
      alpha = true,
      cmp = true,
      dap = true,
      dap_ui = true,
      fidget = true,
      gitsigns = true,
      harpoon = true,
      overseer = true,
      markdown = true,
      mason = true,
      mini = {
        enabled = true,
        indentscope_color = "surface2",
      },
      neotree = true,
      neotest = true,
      native_lsp = {
        enabled = true,
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
        inlay_hints = {
          background = true,
        },
      },
      notify = true,
      treesitter = true,
      treesitter_context = true,
      rainbow_delimiters = true,
      semantic_tokens = true,
      telescope = {
        enabled = true,
      },
      which_key = true,
    },
    custom_highlights = function(colors)
      return {
        Pmenu = { bg = colors.surface0 },
        PmenuSel = { bg = colors.blue, fg = colors.base },
        NormalFloat = { bg = colors.surface0 },
        FloatBorder = { bg = colors.surface0 },
        TelescopeNormal = { bg = colors.surface0 },
        TelescopePromptPrefix = { fg = colors.blue },
        TelescopeSelection = { bg = colors.surface1, fg = colors.text },
        TelescopeMatching = { fg = colors.blue },
        TelescopeSelectionCaret = { fg = colors.blue },
        GitSignsChange = { fg = colors.blue },
        LazyGitFloat = { bg = colors.mantle },
        LazyGitBorder = { fg = colors.mantle },
      }
    end,
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd("colorscheme catppuccin")
  end,
}

-- One Nord Theme
-- ( rainbow delimiters not supported)
-- return {
--   "rmehri01/onenord.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function(_, opts)
--     vim.cmd("colorscheme onenord")
--   end,
-- }

-- Everforest
-- return {
--   "neanias/everforest-nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     vim.cmd("colorscheme everforest")
--   end,
-- }
