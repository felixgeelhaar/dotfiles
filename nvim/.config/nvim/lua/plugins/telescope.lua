return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        enabled = vim.fn.executable("make") == 1,
      },
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local builtin = require("telescope.builtin")

      telescope.setup({
        defaults = {
          path_display = {
            "filename_first",
          },
          prompt_prefix = "  ",
          selection_caret = "  ",
          borderchars = {
            { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
            results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
            preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          },
          winblend = 0,
          file_ignore_patterns = {
            ".DS_Store",
            ".git/",
            "deps/",
            "erl_crash",
            "node_modules/",
            "%.lock",
          },
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
              ["<esc>"] = actions.close,
              ["<C-u>"] = false, -- Clear the prompt instead of scrolling
            },
            n = {
              ["q"] = actions.close,
              ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
            },
          },
          -- Better sorting performance
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--glob=!.git/",
          },
          -- Better previewer setup
          preview = {
            treesitter = true,
            filesize_limit = 1, -- MB
            timeout = 250, -- ms
          },
          -- More responsive UI
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
        },

        pickers = {
          oldfiles = {
            prompt_title = "History",
            cwd_only = false, -- Show all oldfiles, not just current directory
          },
          buffers = {
            sort_mru = true,
            sort_lastused = true,
            show_all_buffers = true,
            ignore_current_buffer = true,
            mappings = {
              i = {
                ["<C-x>"] = "delete_buffer",
              },
              n = {
                ["dd"] = "delete_buffer",
              },
            },
          },
          find_files = {
            hidden = true,
            no_ignore = false,
            follow = true, -- Follow symlinks
          },
          live_grep = {
            additional_args = function()
              return { "--hidden" }
            end,
          },
          current_buffer_fuzzy_find = {
            skip_empty_lines = true,
          },
          lsp_document_symbols = {
            symbol_width = 40, -- Wider symbol column
          },
        },

        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({
              -- More space for displaying results
              width = 0.8,
              previewer = false,
              prompt_title = false,
              borderchars = {
                "─",
                "│",
                "─",
                "│",
                "┌",
                "┐",
                "┘",
                "└",
              },
            }),
          },
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })

      -- Load extensions
      telescope.load_extension("fzf")
      telescope.load_extension("ui-select")

      -- Add notify extension if available
      local has_notify, _ = pcall(require, "telescope._extensions.notify")
      if has_notify then
        telescope.load_extension("notify")
      end

      -- Add noice extension if available
      local has_noice, _ = pcall(require, "telescope._extensions.noice")
      if has_noice then
        telescope.load_extension("noice")
      end

      -- All keymaps are now in the centralized keymaps.lua file
    end,
  },
}
