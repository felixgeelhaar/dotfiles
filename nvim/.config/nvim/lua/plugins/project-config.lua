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