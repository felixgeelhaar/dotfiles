-- Startup performance optimizations and profiling
return {
  -- Startup time measurement
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
      vim.g.startuptime_exe_args = { "+let g:auto_session_enabled = 0" }
    end,
  },

  -- Fast file detection
  {
    "nathom/filetype.nvim",
    lazy = false,
    priority = 10000,
    opts = {
      overrides = {
        extensions = {
          sh = "sh",
          zsh = "sh",
          bash = "sh",
          fish = "fish",
        },
        literal = {
          [".gitignore"] = "gitignore",
          ["Dockerfile"] = "dockerfile",
          ["docker-compose.yml"] = "yaml",
          ["docker-compose.yaml"] = "yaml",
        },
        complex = {
          [".*git/config"] = "gitconfig",
          [".env.*"] = "sh",
        },
      },
    },
  },

  -- Improve startup by reducing shada writes
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
      options = { "buffers", "curdir", "tabpages", "winsize" },
    },
    keys = {
      {
        "<leader>qs",
        function()
          require("persistence").load()
        end,
        desc = "Restore Session",
      },
      {
        "<leader>ql",
        function()
          require("persistence").load({ last = true })
        end,
        desc = "Restore Last Session",
      },
      {
        "<leader>qd",
        function()
          require("persistence").stop()
        end,
        desc = "Don't Save Current Session",
      },
    },
  },
}
