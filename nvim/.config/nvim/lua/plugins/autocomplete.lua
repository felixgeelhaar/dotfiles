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
      use_nvim_cmp_as_default = true,
    },
    
    -- Enable signature help for better development experience
    signature = { 
      enabled = true,
      trigger = {
        blocked_trigger_characters = {},
        blocked_retrigger_characters = {},
      },
      window = {
        min_width = 1,
        max_width = 100,
        max_height = 10,
        border = "rounded",
        winblend = 0,
        scrollbar = false,
      },
    },
    
    -- Optimize completion sources with proper priorities
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      per_filetype = {
        lua = { "lsp", "path", "snippets", "buffer", "lazydev" },
      },
      providers = {
        lsp = {
          name = "LSP",
          module = "blink.cmp.sources.lsp",
          score_offset = 90, -- Highest priority for LSP
        },
        path = {
          name = "Path",
          module = "blink.cmp.sources.path", 
          score_offset = 3,
          opts = {
            trailing_slash = false,
            label_trailing_slash = true,
            get_cwd = function(context) return vim.fn.getcwd() end,
            show_hidden_files_by_default = false,
          },
        },
        snippets = {
          name = "Snippets",
          module = "blink.cmp.sources.snippets",
          score_offset = 85, -- High priority for snippets
        },
        buffer = {
          name = "Buffer",
          module = "blink.cmp.sources.buffer",
          score_offset = 5, -- Lower priority for buffer words
        },
      },
    },
    
    -- Enhanced completion menu appearance
    completion = {
      menu = {
        min_width = 15,
        border = "rounded",
        winblend = 0,
        scrolloff = 2,
        -- Show completion source in menu
        draw = {
          columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "source_name" } },
          components = {
            source_name = {
              width = { max = 30 },
              text = function(ctx) return "[" .. ctx.source_name .. "]" end,
              highlight = "BlinkCmpSource",
            },
          },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        update_delay_ms = 50,
        window = {
          min_width = 10,
          max_width = 60,
          max_height = 20,
          border = "rounded",
          winblend = 0,
        },
      },
      ghost_text = {
        enabled = true,
      },
      -- Accept behavior configuration
      accept = {
        create_undo_point = true,
        auto_brackets = {
          enabled = true,
        },
      },
    },
    
    -- Performance optimizations
    fuzzy = { 
      implementation = "prefer_rust",
    },
  },
  opts_extend = { "sources.default" },
}