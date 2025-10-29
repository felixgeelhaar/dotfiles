-- REST client for API development
return {
  {
    "rest-nvim/rest.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    ft = { "http", "rest" },
    keys = {
      { "<leader>hr", "<Plug>RestNvim", desc = "Run REST Request" },
      { "<leader>hp", "<Plug>RestNvimPreview", desc = "Preview REST Request" },
      { "<leader>hl", "<Plug>RestNvimLast", desc = "Run Last REST Request" },
    },
    config = function()
      require("rest-nvim").setup({
        result_split_horizontal = false,
        result_split_in_place = false,
        skip_ssl_verification = false,
        encode_url = true,
        highlight = {
          enabled = true,
          timeout = 150,
        },
        result = {
          show_url = true,
          show_curl_command = true,
          show_http_info = true,
          show_headers = true,
          formatters = {
            json = "jq",
            html = function(body)
              return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
            end,
          },
        },
        jump_to_request = false,
        env_file = ".env",
        custom_dynamic_variables = {},
        yank_dry_run = true,
        search_back = true,
      })
    end,
  },
}