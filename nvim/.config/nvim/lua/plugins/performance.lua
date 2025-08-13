-- Performance optimizations
return {
  -- Startup time profiling
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
        if vim.bo.filetype == "alpha" then
          return false
        end
        return true
      end,
      autoload = false,
      follow_cwd = true,
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
}