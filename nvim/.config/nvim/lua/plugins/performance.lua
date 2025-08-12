-- Performance optimizations for the ultimate Neovim experience
return {
  -- Faster startup with bytecode compilation
  {
    "lewis6991/impatient.nvim",
    priority = 10000,
    config = function()
      require("impatient").enable_profile()
    end,
  },

  -- Garbage collection optimization
  {
    "garbage-collector",
    lazy = false,
    priority = 9999,
    config = function()
      -- Defer garbage collection during startup
      local gcs = vim.o.gcs
      vim.o.gcs = vim.o.gcs or "n150"
      
      vim.defer_fn(function()
        vim.o.gcs = gcs
      end, 50)
      
      -- Optimize garbage collection
      vim.g.gc_interval = 100
      
      -- Set performance options
      vim.opt.updatetime = 100
      vim.opt.timeoutlen = 300
      vim.opt.redrawtime = 1500
      vim.opt.ttimeoutlen = 10
      vim.opt.ttyfast = true
      vim.opt.lazyredraw = false -- Don't use lazy redraw with smooth scroll
      
      -- Disable some built-in plugins for performance
      local disabled_built_ins = {
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "gzip",
        "zip",
        "zipPlugin",
        "tar",
        "tarPlugin",
        "getscript",
        "getscriptPlugin",
        "vimball",
        "vimballPlugin",
        "2html_plugin",
        "logipat",
        "rrhelper",
        "spellfile_plugin",
        "matchit",
        "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
      }
      
      for _, plugin in pairs(disabled_built_ins) do
        vim.g["loaded_" .. plugin] = 1
      end
      
      -- Optimize for large files
      vim.api.nvim_create_autocmd("BufReadPre", {
        callback = function(args)
          local file = args.file
          local size = vim.fn.getfsize(file)
          if size > 1024 * 1024 then -- 1MB
            vim.b.large_file = true
            vim.cmd("syntax off")
            vim.opt_local.foldmethod = "manual"
            vim.opt_local.spell = false
            vim.opt_local.swapfile = false
            vim.opt_local.undofile = false
            vim.opt_local.undolevels = -1
            vim.opt_local.undoreload = 0
            vim.opt_local.list = false
          end
        end,
      })
    end,
  },

  -- Better startup time profiling
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },

  -- Session management for quick project switching
  {
    "olimorris/persisted.nvim",
    lazy = false,
    priority = 100,
    opts = {
      save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"),
      silent = false,
      use_git_branch = true,
      default_branch = "main",
      autosave = true,
      should_autosave = function()
        -- Don't save if only dashboard is open
        if vim.bo.filetype == "alpha" then
          return false
        end
        return true
      end,
      autoload = false,
      on_autoload_no_session = nil,
      follow_cwd = true,
      allowed_dirs = nil,
      ignored_dirs = {
        "~",
        "~/Downloads",
        "/tmp",
      },
      ignored_file_types = {
        "gitcommit",
        "gitrebase",
        "alpha",
      },
      telescope = {
        reset_prompt = true,
        mappings = {
          change_branch = "<c-b>",
          copy_session = "<c-c>",
          delete_session = "<c-d>",
        },
        icons = {
          branch = " ",
          dir = " ",
          selected = " ",
        },
      },
    },
    config = function(_, opts)
      require("persisted").setup(opts)
      
      -- Telescope integration
      require("telescope").load_extension("persisted")
      
      -- Keymaps
      vim.keymap.set("n", "<leader>ps", "<cmd>SessionSave<cr>", { desc = "Save Session" })
      vim.keymap.set("n", "<leader>pl", "<cmd>SessionLoad<cr>", { desc = "Load Session" })
      vim.keymap.set("n", "<leader>pd", "<cmd>SessionDelete<cr>", { desc = "Delete Session" })
      vim.keymap.set("n", "<leader>pf", "<cmd>Telescope persisted<cr>", { desc = "Find Sessions" })
    end,
  },

  -- Faster file operations
  {
    "nvim-lua/plenary.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- Use plenary's faster file operations
      local Path = require("plenary.path")
      local Job = require("plenary.job")
      
      -- Override vim.fn.filereadable for better performance
      local original_filereadable = vim.fn.filereadable
      vim.fn.filereadable = function(file)
        local path = Path:new(file)
        return path:exists() and path:is_file() and 1 or 0
      end
      
      -- Async file operations
      _G.async_write = function(filename, content)
        Job:new({
          command = "tee",
          args = { filename },
          writer = content,
        }):start()
      end
    end,
  },

  -- Optimized clipboard
  {
    "clipboard-optimizer",
    lazy = false,
    priority = 1000,
    config = function()
      -- Use OSC 52 for SSH sessions
      if vim.env.SSH_TTY then
        local function copy(lines, _)
          require("osc52").copy(table.concat(lines, "\n"))
        end
        
        local function paste()
          return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
        end
        
        vim.g.clipboard = {
          name = "osc52",
          copy = { ["+"] = copy, ["*"] = copy },
          paste = { ["+"] = paste, ["*"] = paste },
        }
      else
        -- Optimize clipboard for local sessions
        vim.g.clipboard = {
          name = "macOS-clipboard",
          copy = {
            ["+"] = "pbcopy",
            ["*"] = "pbcopy",
          },
          paste = {
            ["+"] = "pbpaste",
            ["*"] = "pbpaste",
          },
          cache_enabled = 1,
        }
      end
    end,
  },

  -- Memory usage optimization
  {
    "memory-optimizer",
    event = "VeryLazy",
    config = function()
      -- Limit undo history for memory optimization
      vim.opt.undolevels = 1000
      vim.opt.undoreload = 10000
      
      -- Optimize buffer management
      vim.opt.hidden = true
      vim.opt.bufhidden = "hide"
      vim.opt.swapfile = false
      vim.opt.backup = false
      vim.opt.writebackup = false
      
      -- Auto-close inactive buffers
      vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
        callback = function()
          if vim.bo.modified then
            return
          end
          
          local bufnr = vim.api.nvim_get_current_buf()
          vim.defer_fn(function()
            if not vim.api.nvim_buf_is_valid(bufnr) then
              return
            end
            
            local wins = vim.fn.win_findbuf(bufnr)
            if #wins == 0 and not vim.bo[bufnr].modified then
              -- Check if buffer has been inactive for > 5 minutes
              local last_used = vim.b[bufnr].last_used or os.time()
              if os.time() - last_used > 300 then
                pcall(vim.api.nvim_buf_delete, bufnr, { force = false })
              end
            end
          end, 60000) -- Check after 1 minute
        end,
      })
      
      -- Track buffer usage
      vim.api.nvim_create_autocmd("BufEnter", {
        callback = function()
          vim.b.last_used = os.time()
        end,
      })
    end,
  },

  -- Intelligent lazy loading manager
  {
    "lazy-loading-optimizer",
    lazy = false,
    priority = 100,
    config = function()
      -- Defer loading of heavy plugins
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Load UI enhancements after startup
          vim.defer_fn(function()
            vim.cmd("doautocmd User LoadUIEnhancements")
          end, 50)
          
          -- Load language-specific plugins on demand
          vim.api.nvim_create_autocmd("FileType", {
            pattern = "python",
            once = true,
            callback = function()
              vim.cmd("doautocmd User LoadPythonPlugins")
            end,
          })
          
          vim.api.nvim_create_autocmd("FileType", {
            pattern = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
            once = true,
            callback = function()
              vim.cmd("doautocmd User LoadJSPlugins")
            end,
          })
          
          vim.api.nvim_create_autocmd("FileType", {
            pattern = "go",
            once = true,
            callback = function()
              vim.cmd("doautocmd User LoadGoPlugins")
            end,
          })
        end,
      })
    end,
  },
}