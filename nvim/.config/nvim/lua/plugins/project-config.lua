-- Project-specific configuration support
return {
  {
    "folke/neoconf.nvim",
    priority = 1000, -- Load early for LSP configurations
    config = function()
      require("neoconf").setup({
        -- Import existing json schemas from SchemaStore
        import = {
          vscode = true, -- Support .vscode/settings.json
          coc = false, -- Support coc-settings.json
          nlsp = false, -- Support nlsp-settings.nvim
        },
        -- Live reload when config changes
        live_reload = true,
        -- Config file patterns
        filetype_jsonc = true, -- Treat .nvim.json as jsonc for comments
        
        plugins = {
          -- Configure LSP servers
          lspconfig = {
            enabled = true,
          },
          -- Configure json schemas  
          jsonls = {
            enabled = true,
            configured_servers_only = false,
          },
          -- Configure lua_ls
          lua_ls = {
            enabled = true,
            enabled_for_neovim_config = true,
          },
        },
      })
    end,
  },

  -- Project-local vimrc
  {
    "klen/nvim-config-local",
    config = function()
      require("config-local").setup({
        -- Config file patterns
        config_files = { ".nvim.lua", ".nvimrc", ".exrc" },
        
        -- Where to search for config files
        hashfile = vim.fn.stdpath("data") .. "/config-local",
        
        -- Autocommands to create
        autocommands_create = true,
        
        -- Commands to create
        commands_create = true,
        
        -- Don't echo when loading local config
        silent = false,
        
        -- Lookup config in parent directories
        lookup_parents = false,
      })
    end,
  },

  -- Automatic project root detection
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    config = function()
      require("project_nvim").setup({
        -- How to find root directory
        detection_methods = { "lsp", "pattern" },
        
        -- Patterns to find root
        patterns = {
          ".git",
          "_darcs",
          ".hg",
          ".bzr",
          ".svn",
          "Makefile",
          "package.json",
          "pom.xml",
          "cargo.toml",
          "go.mod",
          "requirements.txt",
          "setup.py",
          "pyproject.toml",
          "composer.json",
        },
        
        -- Don't change directory automatically
        manual_mode = false,
        
        -- When to change directory
        scope_chdir = "global",
        
        -- Show hidden files in telescope
        show_hidden = false,
        
        -- Don't echo messages when changing directory
        silent_chdir = true,
        
        -- What to do when opening Neovim from terminal
        datapath = vim.fn.stdpath("data"),
        
        -- Exclude these directories
        exclude_dirs = {
          "~",
          "~/",
          "/",
        },
      })
      
      -- Telescope integration
      require("telescope").load_extension("projects")
      
      -- Keybinding for project switcher
      vim.keymap.set("n", "<leader>fp", function()
        require("telescope").extensions.projects.projects({})
      end, { desc = "Find Projects" })
    end,
  },

  -- Workspace-specific settings
  {
    "natecraddock/workspaces.nvim",
    cmd = { "WorkspacesList", "WorkspacesAdd", "WorkspacesRemove", "WorkspacesRename" },
    config = function()
      require("workspaces").setup({
        -- Path to store workspaces data
        path = vim.fn.stdpath("data") .. "/workspaces",
        
        -- Automatically cd to workspace on open
        cd_type = "global",
        
        -- Sort workspaces by name
        sort = true,
        
        -- Automatically manage sessions
        auto_open = false,
        
        -- Notify when switching workspaces
        notify_info = true,
        
        -- Hooks
        hooks = {
          -- Before switching workspace
          open_pre = nil,
          
          -- After switching workspace
          open = function()
            -- Load session if it exists
            local Session = require("persistence")
            Session.load()
          end,
        },
      })
      
      -- Telescope integration
      require("telescope").load_extension("workspaces")
      
      -- Keybindings
      vim.keymap.set("n", "<leader>fw", function()
        require("telescope").extensions.workspaces.workspaces()
      end, { desc = "Find Workspaces" })
      
      vim.keymap.set("n", "<leader>wa", "<cmd>WorkspacesAdd<cr>", { desc = "Add Workspace" })
      vim.keymap.set("n", "<leader>wr", "<cmd>WorkspacesRemove<cr>", { desc = "Remove Workspace" })
      vim.keymap.set("n", "<leader>wR", "<cmd>WorkspacesRename<cr>", { desc = "Rename Workspace" })
      vim.keymap.set("n", "<leader>wl", "<cmd>WorkspacesList<cr>", { desc = "List Workspaces" })
    end,
  },

  -- Editorconfig support
  {
    "editorconfig/editorconfig-vim",
    event = "BufReadPre",
  },
}

-- Create template files for project configuration
vim.api.nvim_create_user_command("ProjectInit", function()
  local config_content = [[
-- Project-specific Neovim configuration
-- This file is loaded automatically when entering this project

-- Example: Set project-specific options
vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2

-- Example: Set project-specific keymaps
vim.keymap.set("n", "<leader>pr", "<cmd>!npm run dev<cr>", { buffer = true, desc = "Run dev server" })

-- Example: Load project-specific plugins
-- require("lazy").setup({
--   spec = {
--     { "plugin/name", opts = {} },
--   },
-- })

-- Example: Set up project-specific LSP settings
-- require("lspconfig").tsserver.setup({
--   settings = {
--     typescript = {
--       preferences = {
--         importModuleSpecifier = "relative",
--       },
--     },
--   },
-- })

-- Example: Configure formatters for this project
-- vim.g.conform_formatters_by_ft = {
--   javascript = { "prettier" },
--   typescript = { "prettier" },
-- }

return {}
]]

  local neoconf_content = [[
{
  // Project-specific LSP and plugin configuration
  // See https://github.com/folke/neoconf.nvim for schema
  
  "lspconfig": {
    "lua_ls": {
      "Lua.diagnostics.globals": ["vim"]
    },
    "tsserver": {
      "typescript.preferences.importModuleSpecifier": "relative"
    }
  },
  
  "neotest": {
    "adapters": {
      "jest": {
        "jestCommand": "npm test --"
      }
    }
  },
  
  "conform": {
    "formatters_by_ft": {
      "javascript": ["prettier"],
      "typescript": ["prettier"]
    }
  }
}
]]

  local editorconfig_content = [[
# EditorConfig helps maintain consistent coding styles across different editors
# https://editorconfig.org

root = true

[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
trim_trailing_whitespace = true
indent_style = space
indent_size = 2

[*.{js,jsx,ts,tsx,json}]
indent_size = 2

[*.{py,pyi}]
indent_size = 4

[*.go]
indent_style = tab
indent_size = 4

[*.md]
trim_trailing_whitespace = false

[Makefile]
indent_style = tab
]]

  -- Write the config files
  vim.fn.writefile(vim.split(config_content, "\n"), ".nvim.lua")
  vim.fn.writefile(vim.split(neoconf_content, "\n"), ".nvim.json")
  vim.fn.writefile(vim.split(editorconfig_content, "\n"), ".editorconfig")
  
  print("Created .nvim.lua, .nvim.json, and .editorconfig files for project configuration")
end, { desc = "Initialize project configuration files" })