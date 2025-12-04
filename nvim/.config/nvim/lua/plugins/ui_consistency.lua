return {
  -- Notification system
  {
    "rcarriga/nvim-notify",
    lazy = false,
    priority = 50,
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
      render = "compact",
      stages = "fade",
      background_colour = "#000000",
    },
  },

  -- Consistent UI for vim.ui.select and vim.ui.input
  {
    "stevearc/dressing.nvim",
    lazy = false,
    opts = {
      input = {
        enabled = true,
        border = "rounded",
        relative = "cursor",
        prefer_width = 40,
        win_options = {
          winblend = 0,
        },
      },
      select = {
        enabled = true,
        backend = { "telescope", "builtin" },
        -- Telescope theme is set dynamically when loaded
        get_config = function(opts)
          if opts.kind == "codeaction" then
            return {
              backend = "telescope",
              telescope = require("telescope.themes").get_cursor(),
            }
          end
          return {
            backend = "telescope",
            telescope = require("telescope.themes").get_dropdown(),
          }
        end,
      },
    },
  },

  -- Note: Indent guides configured in indent_line.lua

  -- Code folding
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    event = "BufReadPost",
    opts = {
      provider_selector = function()
        return { "treesitter", "indent" }
      end,
    },
    config = function(_, opts)
      require("ufo").setup(opts)
      vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
    end,
  },
}
