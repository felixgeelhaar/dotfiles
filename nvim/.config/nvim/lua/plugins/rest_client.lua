-- REST client for API development
return {
  {
    "mistweaverco/kulala.nvim",
    ft = { "http", "rest" },
    keys = {
      { "<leader>hr", "<cmd>lua require('kulala').run()<cr>", desc = "Run REST Request" },
      { "<leader>hp", "<cmd>lua require('kulala').replay()<cr>", desc = "Replay Last Request" },
      { "<leader>ht", "<cmd>lua require('kulala').toggle_view()<cr>", desc = "Toggle Headers/Body" },
      { "<leader>hc", "<cmd>lua require('kulala').copy()<cr>", desc = "Copy as cURL" },
      { "<leader>hi", "<cmd>lua require('kulala').inspect()<cr>", desc = "Inspect Request" },
    },
    opts = {
      default_view = "body",
      split_direction = "vertical",
      default_env = "dev",
      debug = false,
    },
  },
}
