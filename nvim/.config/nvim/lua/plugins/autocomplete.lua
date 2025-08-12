return {
  "saghen/blink.cmp",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  version = "1.*",

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = "default" },

    appearance = {
      nerd_font_variant = "mono",
      -- You can enhance UI with lspkind integration
      -- formatting = {
      --   format = require("lspkind").cmp_format({
      --     mode = "symbol_text",
      --     menu = {
      --       buffer = "[Buffer]",
      --       nvim_lsp = "[LSP]",
      --       luasnip = "[Snippet]",
      --       path = "[Path]",
      --       nvim_lua = "[Lua]",
      --     },
      --   }),
      -- },
    },
    signature = { 
      enabled = true,
      window = {
        border = "rounded",
        winblend = 0,
        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
        scrollbar = false,
      },
      trigger = {
        enabled = true,
        show_on_insert_on_trigger_character = true,
      },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },

    fuzzy = { implementation = "prefer_rust" },
  },
  opts_extend = { "sources.default" },
}
