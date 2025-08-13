return {
  -- Automatic project root detection
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    config = function()
      require("project_nvim").setup({
        detection_methods = { "lsp", "pattern" },
        patterns = {
          ".git",
          "package.json",
          "cargo.toml",
          "go.mod",
          "pyproject.toml",
        },
        manual_mode = false,
        scope_chdir = "global",
        show_hidden = false,
        silent_chdir = true,
        exclude_dirs = { "~", "~/", "/" },
      })
      require("telescope").load_extension("projects")
    end,
  },

  -- Editorconfig support
  {
    "editorconfig/editorconfig-vim",
    event = "BufReadPre",
  },
}