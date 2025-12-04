return {
  -- Better search/replace across project
  {
    "nvim-pack/nvim-spectre",
    build = false,
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    keys = {
      {
        "<leader>sr",
        function()
          require("spectre").open()
        end,
        desc = "Replace in files (Spectre)",
      },
    },
  },

  -- Project management with native Telescope approach
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({
            cwd = vim.fn.expand("~/projects"), -- Adjust to your projects directory
            find_command = { "fd", "--type", "d", "--max-depth", "2" },
            prompt_title = "Find Projects",
          })
        end,
        desc = "Find Projects",
      },
    },
  },

  -- Better quickfix
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    opts = {},
  },

  -- Undo tree
  {
    "mbbill/undotree",
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undo Tree" },
    },
  },

  -- Note: Markdown preview is configured in markdown.lua
}
