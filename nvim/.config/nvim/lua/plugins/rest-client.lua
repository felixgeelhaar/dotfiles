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
        -- Open request results in a horizontal split
        result_split_horizontal = false,
        -- Keep the http file buffer above|left when split
        result_split_in_place = false,
        -- Skip SSL cert verification
        skip_ssl_verification = false,
        -- Encode URL before making request
        encode_url = true,
        -- Highlight request on run
        highlight = {
          enabled = true,
          timeout = 150,
        },
        result = {
          -- toggle showing URL, HTTP info, headers at top the of result window
          show_url = true,
          show_curl_command = true,
          show_http_info = true,
          show_headers = true,
          -- table of curl `--write-out` variables
          -- https://curl.se/docs/manpage.html#-w
          formatters = {
            json = "jq",
            html = function(body)
              return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
            end,
          },
        },
        -- Jump to request line on run
        jump_to_request = false,
        env_file = ".env",
        custom_dynamic_variables = {},
        yank_dry_run = true,
        search_back = true,
      })

      -- Create HTTP file template
      vim.api.nvim_create_autocmd("BufNewFile", {
        pattern = "*.http",
        callback = function()
          local lines = {
            "### Example GET request",
            "GET https://api.github.com/user",
            "Accept: application/json",
            "Authorization: Bearer {{token}}",
            "",
            "### Example POST request",
            "POST https://jsonplaceholder.typicode.com/posts",
            "Content-Type: application/json",
            "",
            "{",
            '  "title": "foo",',
            '  "body": "bar",',
            '  "userId": 1',
            "}",
            "",
            "### Example with variables",
            "# @base_url = https://api.example.com",
            "# @token = your-api-token",
            "",
            "GET {{base_url}}/users",
            "Authorization: Bearer {{token}}",
            "",
            "### Example with environment variables",
            "# Uses .env file in project root",
            "GET {{$dotenv API_URL}}/status",
            "X-API-Key: {{$dotenv API_KEY}}",
          }
          vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
        end,
      })
    end,
  },
  -- Alternative: kulala.nvim - Modern REST client
  {
    "mistweaverco/kulala.nvim",
    enabled = false, -- Enable this and disable rest.nvim if you prefer kulala
    ft = { "http", "rest" },
    keys = {
      { "<leader>hr", function() require("kulala").run() end, desc = "Run REST Request" },
      { "<leader>ha", function() require("kulala").run_all() end, desc = "Run All Requests" },
      { "<leader>hp", function() require("kulala").jump_prev() end, desc = "Previous Request" },
      { "<leader>hn", function() require("kulala").jump_next() end, desc = "Next Request" },
      { "<leader>hc", function() require("kulala").close() end, desc = "Close Response" },
      { "<leader>ht", function() require("kulala").toggle_view() end, desc = "Toggle View" },
      { "<leader>hi", function() require("kulala").inspect() end, desc = "Inspect Request" },
      { "<leader>hC", function() require("kulala").copy() end, desc = "Copy as cURL" },
    },
    config = function()
      require("kulala").setup({
        -- Default config, adjust as needed
        default_view = "body",
        default_env = "dev",
        debug = false,
        contenttypes = {
          ["application/json"] = {
            ft = "json",
            formatter = { "jq", "." },
          },
          ["application/xml"] = {
            ft = "xml",
            formatter = { "xmllint", "--format", "-" },
          },
          ["text/html"] = {
            ft = "html",
            formatter = { "prettier", "--parser", "html" },
          },
        },
        show_icons = "on_request",
        icons = {
          inlay = {
            loading = "⏳",
            done = "✅",
            error = "❌",
          },
          lualine = "🌐",
        },
      })
    end,
  },
}