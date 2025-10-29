return {
  "kdheepak/lazygit.nvim",
  -- optional for floating window border decoration
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  -- keymaps moved to main keymaps.lua for centralization
  -- opts = {
  -- -- your configuration comes here
  -- -- or leave it empty to use the default settings
  -- -- refer to the configuration section below
  -- },
  -- setup = function() end,
}
