return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      -- Disable folding for neo-tree buffers with autocmd
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "neo-tree",
        callback = function()
          vim.wo.foldenable = false
          vim.wo.foldcolumn = "0"
        end,
      })

      require("neo-tree").setup({
        close_if_last_window = true,
        popup_border_style = "rounded",
        filesystem = {
          follow_current_file = { enabled = true },
          hijack_netrw_behavior = "open_default", -- Add this to replace netrw
          use_libuv_file_watcher = true, -- Add this for better file system watching
        },
        enable_git_status = true,
        enable_diagnostics = true,
        event_handlers = {
          {
            event = "file_opened",
            handler = function(_)
              require("neo-tree.command").execute({ action = "close" })
            end,
          },
          -- Add refresh on file write
          {
            event = "file_renamed",
            handler = function(_)
              require("neo-tree.sources.filesystem").refresh()
            end,
          },
          -- Disable folding in neo-tree buffer
          {
            event = "neo_tree_buffer_enter",
            handler = function()
              vim.wo.foldenable = false
              vim.wo.foldcolumn = "0"
            end,
          },
        },
        -- Improve your default_component_configs with more comprehensive settings:
        default_component_configs = {
          indent = {
            with_markers = false,
            with_expanders = true,
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
          },
          modified = { symbol = "󰐗" },
          git_status = {
            symbols = {
              added = "✚", -- Add more distinctive symbols
              modified = "",
              deleted = "✖", -- Show deletion clearly
              renamed = "󰁕",
              untracked = "",
              ignored = "",
              unstaged = "",
              staged = "",
              conflict = "",
            },
          },
          name = {
            trailing_slash = true, -- Show trailing slash for directories
            use_git_status_colors = true,
          },
          icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "󰜌",
          },
        },
      })
    end,
  }
}

