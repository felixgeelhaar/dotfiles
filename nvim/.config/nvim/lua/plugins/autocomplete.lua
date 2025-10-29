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
    -- Shows function signatures while typing, positioned above completion menu
    signature = {
      enabled = true,
      trigger = {
        blocked_trigger_characters = {},
        blocked_retrigger_characters = {},
        -- Show signature help immediately when entering function call
        show_on_insert_on_trigger_character = true,
      },
      window = {
        min_width = 1,
        max_width = 120, -- Increased for full function signatures
        max_height = 12, -- Slightly taller for multi-param functions
        border = "rounded",
        winblend = 0,
        scrollbar = true, -- Enable scrollbar for long signatures
        -- Position above completion menu for simultaneous visibility
        -- blink.cmp automatically positions signature above completion
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
            get_cwd = function(context)
              return vim.fn.getcwd()
            end,
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
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100, -- Highest priority for Neovim Lua API
        },
      },
    },

    -- Enhanced completion menu appearance with more type information
    completion = {
      menu = {
        min_width = 20, -- Slightly wider for better readability
        max_height = 15, -- More items visible at once
        border = "rounded",
        winblend = 0,
        scrolloff = 2,
        -- Show completion source and enhanced type information
        draw = {
          columns = {
            { "kind_icon" },
            { "label", "label_description", gap = 1 },
            { "kind" }, -- Add kind text (Function, Variable, etc.)
            { "source_name" },
          },
          components = {
            kind_icon = {
              width = { fill = false },
            },
            label = {
              width = { fill = true, max = 60 }, -- Wider labels for full function names
            },
            label_description = {
              width = { max = 50 }, -- Increased for full type signatures
            },
            kind = {
              width = { max = 15 },
              text = function(ctx)
                return ctx.kind
              end,
              highlight = "BlinkCmpKind",
            },
            source_name = {
              width = { max = 20 },
              text = function(ctx)
                return "[" .. ctx.source_name .. "]"
              end,
              highlight = "BlinkCmpSource",
            },
          },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 100, -- Reduced from 200ms for faster feedback
        update_delay_ms = 50, -- Keep fast updates
        window = {
          min_width = 15,
          max_width = 80, -- Wider for better type information display
          max_height = 25, -- Taller for detailed documentation
          border = "rounded",
          winblend = 0,
          scrollbar = true, -- Enable scrollbar for long docs
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
