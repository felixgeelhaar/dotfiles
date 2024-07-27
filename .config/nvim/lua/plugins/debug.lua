return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    { 'theHamsta/nvim-dap-virtual-text', opts = {} },
    -- Add your own debuggers here
    { 'leoluz/nvim-dap-go', opts = {} },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    require('overseer').enable_dap()
    require('mason-nvim-dap').setup {
      automatic_installation = true,
      automatic_setup = true,

      -- You can provide additional configuration to the handlers,
      handlers = {},

      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
      },
    }

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })

    -- dapui.setup {
    --   mappings = {},
    --   icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
    --   controls = {
    --     icons = {
    --       pause = '⏸',
    --       play = '▶',
    --       step_into = '⏎',
    --       step_over = '⏭',
    --       step_out = '⏮',
    --       step_back = 'b',
    --       run_last = '▶▶',
    --       terminate = '⏹',
    --       disconnect = '⏏',
    --     },
    --   },
    -- }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close
  end,
}

-- {
--   "mfussenegger/nvim-dap",
--   optional = true,
--   dependencies = {
--     {
--       "williamboman/mason.nvim",
--       opts = function(_, opts)
--         opts.ensure_installed = opts.ensure_installed or {}
--         table.insert(opts.ensure_installed, "js-debug-adapter")
--       end,
--     },
--   },
--   opts = function()
--     local dap = require("dap")
--     if not dap.adapters["pwa-node"] then
--       require("dap").adapters["pwa-node"] = {
--         type = "server",
--         host = "localhost",
--         port = "${port}",
--         executable = {
--           command = "node",
--           -- 💀 Make sure to update this path to point to your installation
--           args = {
--             LazyVim.get_pkg_path("js-debug-adapter", "/js-debug/src/dapDebugServer.js"),
--             "${port}",
--           },
--         },
--       }
--     end
--     if not dap.adapters["node"] then
--       dap.adapters["node"] = function(cb, config)
--         if config.type == "node" then
--           config.type = "pwa-node"
--         end
--         local nativeAdapter = dap.adapters["pwa-node"]
--         if type(nativeAdapter) == "function" then
--           nativeAdapter(cb, config)
--         else
--           cb(nativeAdapter)
--         end
--       end
--     end
--
--     local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }
--
--     local vscode = require("dap.ext.vscode")
--     vscode.type_to_filetypes["node"] = js_filetypes
--     vscode.type_to_filetypes["pwa-node"] = js_filetypes
--
--     for _, language in ipairs(js_filetypes) do
--       if not dap.configurations[language] then
--         dap.configurations[language] = {
--           {
--             type = "pwa-node",
--             request = "launch",
--             name = "Launch file",
--             program = "${file}",
--             cwd = "${workspaceFolder}",
--           },
--           {
--             type = "pwa-node",
--             request = "attach",
--             name = "Attach",
--             processId = require("dap.utils").pick_process,
--             cwd = "${workspaceFolder}",
--           },
--         }
--       end
--     end
--   end,
-- }
