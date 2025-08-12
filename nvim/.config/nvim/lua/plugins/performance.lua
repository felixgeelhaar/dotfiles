-- Performance optimizations for the ultimate Neovim experience
return {
  -- Faster startup with bytecode compilation
  {
    "lewis6991/impatient.nvim",
    priority = 10000,
    config = function()
      require("impatient").enable_profile()
    end,
  },

  -- Better startup time profiling
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },

  -- Session management for quick project switching
  {
    "olimorris/persisted.nvim",
    lazy = false,
    priority = 100,
    opts = {
      save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"),
      silent = false,
      use_git_branch = true,
      default_branch = "main",
      autosave = true,
      should_autosave = function()
        -- Don't save if only dashboard is open
        if vim.bo.filetype == "alpha" then
          return false
        end
        return true
      end,
      autoload = false,
      on_autoload_no_session = nil,
      follow_cwd = true,
      allowed_dirs = nil,
      ignored_dirs = {
        "~",
        "~/Downloads",
        "/tmp",
      },
      ignored_file_types = {
        "gitcommit",
        "gitrebase",
        "alpha",
      },
      telescope = {
        reset_prompt = true,
        mappings = {
          change_branch = "<c-b>",
          copy_session = "<c-c>",
          delete_session = "<c-d>",
        },
        icons = {
          branch = " ",
          dir = " ",
          selected = " ",
        },
      },
    },
    config = function(_, opts)
      require("persisted").setup(opts)
      
      -- Telescope integration
      require("telescope").load_extension("persisted")
      
      -- Keymaps
      vim.keymap.set("n", "<leader>ps", "<cmd>SessionSave<cr>", { desc = "Save Session" })
      vim.keymap.set("n", "<leader>pl", "<cmd>SessionLoad<cr>", { desc = "Load Session" })
      vim.keymap.set("n", "<leader>pd", "<cmd>SessionDelete<cr>", { desc = "Delete Session" })
      vim.keymap.set("n", "<leader>pf", "<cmd>Telescope persisted<cr>", { desc = "Find Sessions" })
    end,
  },

  -- Faster file operations (plenary is already loaded elsewhere, just configure here)
  {
    "nvim-lua/plenary.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- Use plenary's faster file operations
      local Path = require("plenary.path")
      local Job = require("plenary.job")
      
      -- Override vim.fn.filereadable for better performance
      local original_filereadable = vim.fn.filereadable
      vim.fn.filereadable = function(file)
        local path = Path:new(file)
        return path:exists() and path:is_file() and 1 or 0
      end
      
      -- Async file operations
      _G.async_write = function(filename, content)
        Job:new({
          command = "tee",
          args = { filename },
          writer = content,
        }):start()
      end
    end,
  },
}