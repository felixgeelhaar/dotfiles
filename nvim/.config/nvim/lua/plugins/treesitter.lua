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
          "jsonc",
          "json5",
          "lua",
          "luadoc",
          "luap",
          "markdown",
          "markdown_inline",
          "python",
          "rust",
          "toml",
          "typescript",
          "tsx",
          "javascript",
          "jsdoc",
          "sql",
          "yaml",
          "regex",
          "css",
          "scss",
          "dockerfile",
          "gitignore",
          "gitcommit",
          "gitattributes",
          "vim",
          "vimdoc",
          "query",
          "c",
          "cpp",
          "cmake",
          "make",
          "diff",
          "http",
          "xml",
        },

        -- Module configuration
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
          -- Disable slow treesitter highlight for large files
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
        },

        indent = {
          enable = true,
          -- Disable indent for problematic languages
          disable = { "yaml", "python" },
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

        -- Note: Folding is configured in opts.lua via foldexpr
        -- Note: For HTML autotag, install nvim-ts-autotag plugin separately
      })

      -- Modern treesitter folding is now handled in opts.lua
      -- This provides better integration with other fold settings
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    enabled = true,
    opts = {
      mode = "cursor",
      max_lines = 3,
      min_window_height = 10,
      line_numbers = true,
      multiline_threshold = 1,
      trim_scope = "outer",
      zindex = 20,
      on_attach = function(buf)
        -- Disable in very large files for performance
        local max_filesize = 100 * 1024 -- 100 KB
        local filename = vim.api.nvim_buf_get_name(buf)
        local ok, stats = pcall(vim.uv.fs_stat, filename)
        if ok and stats and stats.size > max_filesize then
          return false
        end
        return true
      end,
    },
    config = function(_, opts)
      require("treesitter-context").setup(opts)

      -- Add keymap to toggle context
      vim.keymap.set("n", "<leader>tc", function()
        require("treesitter-context").toggle()
      end, { desc = "Toggle Treesitter Context" })
    end,
  },
}
