-- Comprehensive testing framework integration
return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- Language-specific adapters
      "nvim-neotest/neotest-go",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-jest",
      "rouge8/neotest-rust",
      "marilari88/neotest-vitest",
    },
    keys = {
      {
        "<leader>tt",
        function()
          require("neotest").run.run()
        end,
        desc = "Run Nearest Test",
      },
      {
        "<leader>tT",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Run Test File",
      },
      {
        "<leader>ta",
        function()
          require("neotest").run.run(vim.uv.cwd())
        end,
        desc = "Run All Tests",
      },
      {
        "<leader>ts",
        function()
          require("neotest").summary.toggle()
        end,
        desc = "Toggle Test Summary",
      },
      {
        "<leader>to",
        function()
          require("neotest").output.open({ enter = true, auto_close = true })
        end,
        desc = "Show Test Output",
      },
      {
        "<leader>tO",
        function()
          require("neotest").output_panel.toggle()
        end,
        desc = "Toggle Output Panel",
      },
      {
        "<leader>tS",
        function()
          require("neotest").run.stop()
        end,
        desc = "Stop Test",
      },
      {
        "<leader>tw",
        function()
          require("neotest").watch.toggle(vim.fn.expand("%"))
        end,
        desc = "Watch Test File",
      },
      {
        "<leader>tW",
        function()
          require("neotest").watch.toggle(vim.uv.cwd())
        end,
        desc = "Watch All Tests",
      },
      -- Debugging tests
      {
        "<leader>td",
        function()
          require("neotest").run.run({ strategy = "dap" })
        end,
        desc = "Debug Nearest Test",
      },
      {
        "<leader>tD",
        function()
          require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" })
        end,
        desc = "Debug Test File",
      },
      -- Test navigation
      {
        "[t",
        function()
          require("neotest").jump.prev({ status = "failed" })
        end,
        desc = "Jump to Previous Failed Test",
      },
      {
        "]t",
        function()
          require("neotest").jump.next({ status = "failed" })
        end,
        desc = "Jump to Next Failed Test",
      },
    },
    config = function()
      local neotest = require("neotest")

      neotest.setup({
        adapters = {
          -- Go testing
          require("neotest-go")({
            experimental = {
              test_table = true,
            },
            args = { "-count=1", "-timeout=60s" },
          }),

          -- Python testing
          require("neotest-python")({
            dap = { justMyCode = false },
            runner = "pytest",
            python = ".venv/bin/python",
          }),

          -- JavaScript/TypeScript testing
          require("neotest-jest")({
            jestCommand = "npm test --",
            jestConfigFile = "jest.config.js",
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          }),

          -- Vitest for modern JS/TS projects
          require("neotest-vitest"),

          -- Rust testing
          require("neotest-rust")({
            args = { "--no-capture" },
            dap_adapter = "codelldb",
          }),
        },

        -- UI configuration
        summary = {
          animated = true,
          enabled = true,
          expand_errors = true,
          follow = true,
          mappings = {
            attach = "a",
            clear_marked = "M",
            clear_target = "T",
            debug = "d",
            debug_marked = "D",
            expand = { "<CR>", "<2-LeftMouse>" },
            expand_all = "e",
            jumpto = "i",
            mark = "m",
            next_failed = "J",
            output = "o",
            prev_failed = "K",
            run = "r",
            run_marked = "R",
            short = "O",
            stop = "u",
            target = "t",
            watch = "w",
          },
        },

        icons = {
          failed = "",
          passed = "",
          running = "",
          skipped = "",
          unknown = "",
          watching = "",
        },

        output = {
          enabled = true,
          open_on_run = "short",
        },

        output_panel = {
          enabled = true,
          open = "botright split | resize 15",
        },

        quickfix = {
          enabled = false,
          open = false,
        },

        status = {
          enabled = true,
          signs = true,
          virtual_text = false,
        },

        strategies = {
          integrated = {
            height = 40,
            width = 120,
          },
        },

        floating = {
          border = "rounded",
          max_height = 0.9,
          max_width = 0.9,
          options = {},
        },

        highlights = {
          adapter_name = "NeotestAdapterName",
          border = "NeotestBorder",
          dir = "NeotestDir",
          expand_marker = "NeotestExpandMarker",
          failed = "NeotestFailed",
          file = "NeotestFile",
          focused = "NeotestFocused",
          indent = "NeotestIndent",
          marked = "NeotestMarked",
          namespace = "NeotestNamespace",
          passed = "NeotestPassed",
          running = "NeotestRunning",
          select_win = "NeotestWinSelect",
          skipped = "NeotestSkipped",
          target = "NeotestTarget",
          test = "NeotestTest",
          unknown = "NeotestUnknown",
          watching = "NeotestWatching",
        },

        -- Performance settings
        discovery = {
          concurrent = 4,
          enabled = true,
        },

        running = {
          concurrent = true,
        },

        state = {
          enabled = true,
        },
      })

      -- Set up custom highlight groups
      vim.api.nvim_set_hl(0, "NeotestPassed", { fg = "#98c379" })
      vim.api.nvim_set_hl(0, "NeotestFailed", { fg = "#e06c75" })
      vim.api.nvim_set_hl(0, "NeotestRunning", { fg = "#e5c07b" })
      vim.api.nvim_set_hl(0, "NeotestSkipped", { fg = "#56b6c2" })
    end,
  },
}
