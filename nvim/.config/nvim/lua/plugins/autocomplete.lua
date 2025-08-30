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
        -- Show signature help on function calls
        show_trigger_characters = { "(", "," },
      },
      window = {
        min_width = 1,
        max_width = 100,
        max_height = 10,
        border = "rounded",
        winblend = 0,
        scrolloff = 2,
        -- Close signature help automatically when appropriate
        close_on_cursor_move = { 'i' },
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
        max_items = 200,
        min_width = 15,
        max_width = 60,
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
          scrolloff = 2,
        },
      },
      ghost_text = {
        enabled = true,
      },
    },
    
    -- Performance optimizations
    fuzzy = { 
      implementation = "prefer_rust",
      -- Prebuilt binaries for better performance
      use_typos_check = false,
      max_items = 200,
    },
    
    -- Enhanced accept behavior
    accept = {
      create_undo_point = true,
      auto_brackets = {
        enabled = true,
        default_brackets = { "(", ")" },
        override_brackets_for_filetypes = {},
        force_allow_filetypes = {},
        blocked_filetypes = {},
        kind_resolution = {
          enabled = true,
          blocked_filetypes = { "typescriptreact", "javascriptreact", "vue" },
        },
        semantic_token_resolution = {
          enabled = true,
          blocked_filetypes = {},
        },
      },
    },
  },
  opts_extend = { "sources.default" },
}