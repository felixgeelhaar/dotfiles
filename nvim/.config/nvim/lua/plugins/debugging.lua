-- Debug Adapter Protocol (DAP) Configuration
-- Provides debugging support for multiple languages

return {
  -- DAP Core
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- UI for DAP
      {
        "rcarriga/nvim-dap-ui",
        opts = {},
        config = function(_, opts)
          local dap = require("dap")
          local dapui = require("dapui")
          dapui.setup(opts)
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
          end
        end,
      },
      
      -- Virtual text for debugging
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
      
      -- Mason integration for DAP
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = "mason.nvim",
        cmd = { "DapInstall", "DapUninstall" },
        opts = {
          automatic_installation = true,
          handlers = {},
          ensure_installed = {
            "delve",      -- Go
            "debugpy",    -- Python
            "codelldb",   -- Rust, C, C++
            "js-debug-adapter", -- JavaScript/TypeScript
            "node-debug2-adapter", -- Node.js
            "bash-debug-adapter", -- Bash
            "php-debug-adapter", -- PHP
          },
        },
      },
    },
    
    keys = {
      -- Function keys for common debugging operations
      { "<F5>", function() require("dap").continue() end, desc = "Debug: Continue" },
      { "<F10>", function() require("dap").step_over() end, desc = "Debug: Step Over" },
      { "<F11>", function() require("dap").step_into() end, desc = "Debug: Step Into" },
      { "<F12>", function() require("dap").step_out() end, desc = "Debug: Step Out" },
      
      -- Leader-based debugging commands
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Conditional Breakpoint" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>dj", function() require("dap").down() end, desc = "Stack Down" },
      { "<leader>dk", function() require("dap").up() end, desc = "Stack Up" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
      { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end, desc = "Session Info" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Debug Widgets" },
      { "<leader>du", function() require("dapui").toggle({ reset = true }) end, desc = "Toggle Debug UI" },
      { "<leader>de", function() require("dapui").eval() end, desc = "Evaluate Expression", mode = {"n", "v"} },
      
      -- Clear all breakpoints
      { "<leader>dD", function() require("dap").clear_breakpoints() end, desc = "Clear All Breakpoints" },
      
      -- Show breakpoints in telescope
      { "<leader>dL", function() require("dap").list_breakpoints() end, desc = "List Breakpoints" },
    },
    
    config = function()
      local dap = require("dap")
      
      -- DAP Icons
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
      
      for name, sign in pairs({
        DapBreakpoint = { "●", "DiagnosticError" },
        DapBreakpointCondition = { "●", "DiagnosticWarn" },
        DapBreakpointRejected = { "●", "DiagnosticError" },
        DapLogPoint = { "◆", "DiagnosticInfo" },
        DapStopped = { "▶", "DiagnosticWarn" },
      }) do
        vim.fn.sign_define(name, { text = sign[1], texthl = sign[2], linehl = "", numhl = "" })
      end
      
      -- Python DAP Configuration
      dap.adapters.python = function(cb, config)
        if config.request == "attach" then
          local port = (config.connect or config).port
          local host = (config.connect or config).host or "127.0.0.1"
          cb({
            type = "server",
            port = assert(port, "`connect.port` is required for a python `attach` configuration"),
            host = host,
            options = {
              source_filetype = "python",
            },
          })
        else
          cb({
            type = "executable",
            command = "python",
            args = { "-m", "debugpy.adapter" },
            options = {
              source_filetype = "python",
            },
          })
        end
      end
      
      -- Helper function to find Python interpreter
      local function get_python_path()
        local cwd = vim.fn.getcwd()
        -- Try common virtual environment locations
        local python_paths = {
          cwd .. "/venv/bin/python",
          cwd .. "/.venv/bin/python",
          vim.fn.expand("~/.pyenv/shims/python"),
          "/usr/local/bin/python3",
          "/usr/bin/python3",
          "/usr/bin/python",
        }

        for _, path in ipairs(python_paths) do
          if vim.fn.executable(path) == 1 then
            return path
          end
        end

        -- Fallback to system python
        return "python3"
      end

      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          pythonPath = get_python_path,
        },
        {
          type = "python",
          request = "launch",
          name = "Launch file with arguments",
          program = "${file}",
          args = function()
            local args_string = vim.fn.input("Arguments: ")
            return vim.split(args_string, " ")
          end,
          pythonPath = get_python_path,
        },
      }
      
      -- Go DAP Configuration
      dap.adapters.delve = {
        type = "server",
        port = "${port}",
        executable = {
          command = "dlv",
          args = { "dap", "-l", "127.0.0.1:${port}" },
        },
      }
      
      dap.configurations.go = {
        {
          type = "delve",
          name = "Debug",
          request = "launch",
          program = "${file}",
        },
        {
          type = "delve",
          name = "Debug test",
          request = "launch",
          mode = "test",
          program = "${file}",
        },
        {
          type = "delve",
          name = "Debug test (go.mod)",
          request = "launch",
          mode = "test",
          program = "./${relativeFileDirname}",
        },
      }
      
      -- Rust DAP Configuration
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = "codelldb",
          args = { "--port", "${port}" },
        },
      }
      
      dap.configurations.rust = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
      
      -- C/C++ DAP Configuration
      dap.configurations.c = dap.configurations.rust
      dap.configurations.cpp = dap.configurations.rust
      
      -- JavaScript/TypeScript DAP Configuration
      for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-chrome",
            request = "launch",
            name = "Start Chrome with \"localhost\"",
            url = "http://localhost:3000",
            webRoot = "${workspaceFolder}",
            userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
          },
        }
      end

      -- Bash DAP Configuration
      dap.adapters.bashdb = {
        type = "executable",
        command = "bash-debug-adapter",
        name = "bashdb",
      }

      dap.configurations.sh = {
        {
          type = "bashdb",
          request = "launch",
          name = "Launch Bash Script",
          program = "${file}",
          cwd = "${workspaceFolder}",
          pathBashdb = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb",
          pathBashdbLib = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir",
          pathBash = "bash",
          pathCat = "cat",
          pathMkfifo = "mkfifo",
          pathPkill = "pkill",
          args = {},
          env = {},
          terminalKind = "integrated",
        },
      }

      -- PHP DAP Configuration
      dap.adapters.php = {
        type = "executable",
        command = "php-debug-adapter",
      }

      dap.configurations.php = {
        {
          type = "php",
          request = "launch",
          name = "Listen for Xdebug",
          port = 9003, -- Xdebug 3 default port (9000 for Xdebug 2)
          pathMappings = {
            ["/var/www/html"] = "${workspaceFolder}",
          },
        },
        {
          type = "php",
          request = "launch",
          name = "Launch currently open script",
          program = "${file}",
          cwd = "${workspaceFolder}",
          port = 9003,
        },
      }
    end,
  },

  -- Language-specific debugging extensions
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      require("dap-python").setup("python")
    end,
  },
  
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      require("dap-go").setup()
    end,
  },
}