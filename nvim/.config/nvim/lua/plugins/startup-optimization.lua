-- Startup optimization and measurement
return {
  -- Display startup time in alpha dashboard
  {
    "startup-time-display",
    lazy = false,
    priority = 1000,
    config = function()
      -- Track startup time
      if vim.fn.has("nvim-0.9") == 1 then
        vim.g.startup_time = vim.loop.hrtime()
        
        vim.api.nvim_create_autocmd("User", {
          pattern = "LazyVimStarted",
          once = true,
          callback = function()
            local startup_time = (vim.loop.hrtime() - vim.g.startup_time) / 1000000
            vim.g.startup_time_ms = startup_time
            
            -- Show startup time in statusline temporarily
            vim.defer_fn(function()
              vim.notify(
                string.format("⚡ Neovim loaded in %.2f ms", startup_time),
                vim.log.levels.INFO,
                { title = "Startup Performance" }
              )
            end, 100)
            
            -- Log detailed timing if over threshold
            if startup_time > 150 then
              vim.defer_fn(function()
                vim.notify(
                  "Startup took longer than expected. Run :StartupTime for analysis",
                  vim.log.levels.WARN,
                  { title = "Performance Warning" }
                )
              end, 1000)
            end
          end,
        })
      end
    end,
  },

  -- Optimize plugin loading order
  {
    "plugin-load-optimizer",
    lazy = false,
    priority = 10001,
    config = function()
      -- Set optimal loading priorities for plugins
      local plugin_priorities = {
        ["impatient.nvim"] = 10000,
        ["catppuccin"] = 9999,
        ["lazy.nvim"] = 9998,
        ["plenary.nvim"] = 9997,
        ["nvim-treesitter"] = 9996,
        ["nvim-lspconfig"] = 9995,
        ["telescope.nvim"] = 100,
        ["nvim-cmp"] = 99,
        ["which-key.nvim"] = 98,
        ["gitsigns.nvim"] = 97,
        ["neo-tree.nvim"] = 96,
      }
      
      -- Apply priorities to lazy.nvim specs
      local lazy_config = require("lazy.core.config")
      local original_spec = lazy_config.spec
      
      lazy_config.spec = function(...)
        local spec = original_spec(...)
        for name, priority in pairs(plugin_priorities) do
          for _, plugin in ipairs(spec.plugins) do
            if plugin[1] and plugin[1]:match(name) then
              plugin.priority = plugin.priority or priority
            end
          end
        end
        return spec
      end
    end,
  },

  -- Automatic cache management
  {
    "cache-manager",
    event = "VeryLazy",
    config = function()
      -- Clear old cache files periodically
      local cache_dir = vim.fn.stdpath("cache")
      
      local function clean_cache()
        -- Clean files older than 7 days
        local handle = vim.loop.fs_scandir(cache_dir)
        if not handle then return end
        
        local now = os.time()
        local week_ago = now - (7 * 24 * 60 * 60)
        
        while true do
          local name, type = vim.loop.fs_scandir_next(handle)
          if not name then break end
          
          if type == "file" then
            local path = cache_dir .. "/" .. name
            local stat = vim.loop.fs_stat(path)
            if stat and stat.mtime.sec < week_ago then
              vim.loop.fs_unlink(path)
            end
          end
        end
      end
      
      -- Run cache cleanup on startup and weekly
      vim.defer_fn(clean_cache, 5000)
      
      -- Schedule weekly cleanup
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          local last_cleanup = vim.g.last_cache_cleanup or 0
          local now = os.time()
          if now - last_cleanup > (7 * 24 * 60 * 60) then
            clean_cache()
            vim.g.last_cache_cleanup = now
          end
        end,
      })
    end,
  },

  -- Smart plugin compilation
  {
    "plugin-compiler",
    lazy = false,
    priority = 9000,
    config = function()
      -- Compile Lua modules for faster loading
      local compile = function()
        -- Compile configuration files
        local config_path = vim.fn.stdpath("config") .. "/lua"
        vim.loader.enable()
        
        -- Pre-compile frequently used modules
        local modules = {
          "telescope",
          "nvim-treesitter",
          "lspconfig",
          "mason",
          "lazy",
        }
        
        for _, mod in ipairs(modules) do
          pcall(require, mod)
        end
      end
      
      -- Compile after first startup
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        once = true,
        callback = function()
          vim.defer_fn(compile, 1000)
        end,
      })
    end,
  },

  -- Startup profiler command
  {
    "startup-profiler",
    cmd = "StartupProfile",
    config = function()
      vim.api.nvim_create_user_command("StartupProfile", function()
        local profile = {}
        local total_time = vim.g.startup_time_ms or 0
        
        -- Collect plugin load times
        local lazy_stats = require("lazy").stats()
        
        -- Create profile report
        local lines = {
          "# Neovim Startup Profile",
          "",
          string.format("Total startup time: %.2f ms", total_time),
          string.format("Plugins loaded: %d", lazy_stats.count),
          string.format("Lazy loading time: %.2f ms", lazy_stats.times.LazyDone),
          "",
          "## Top 10 Slowest Plugins:",
          "",
        }
        
        -- Sort plugins by load time
        local plugins = {}
        for name, plugin in pairs(require("lazy.core.config").plugins) do
          if plugin._.loaded then
            table.insert(plugins, {
              name = name,
              time = plugin._.loaded.time or 0,
            })
          end
        end
        
        table.sort(plugins, function(a, b)
          return a.time > b.time
        end)
        
        -- Add top 10 to report
        for i = 1, math.min(10, #plugins) do
          local plugin = plugins[i]
          table.insert(lines, string.format("%d. %s: %.2f ms", i, plugin.name, plugin.time))
        end
        
        -- Show in new buffer
        vim.cmd("tabnew")
        local buf = vim.api.nvim_get_current_buf()
        vim.bo[buf].filetype = "markdown"
        vim.bo[buf].buftype = "nofile"
        vim.bo[buf].bufhidden = "wipe"
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
        vim.bo[buf].modifiable = false
      end, {
        desc = "Show detailed startup profiling information",
      })
    end,
  },
}