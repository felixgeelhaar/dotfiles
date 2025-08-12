-- Advanced code refactoring capabilities
return {
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      -- Extract function supports visual mode
      {
        "<leader>re",
        function()
          require("refactoring").refactor("Extract Function")
        end,
        mode = "x",
        desc = "Extract Function",
      },
      {
        "<leader>rf",
        function()
          require("refactoring").refactor("Extract Function To File")
        end,
        mode = "x",
        desc = "Extract Function To File",
      },
      -- Extract variable supports visual mode
      {
        "<leader>rv",
        function()
          require("refactoring").refactor("Extract Variable")
        end,
        mode = "x",
        desc = "Extract Variable",
      },
      -- Inline variable supports both normal and visual mode
      {
        "<leader>ri",
        function()
          require("refactoring").refactor("Inline Variable")
        end,
        mode = { "n", "x" },
        desc = "Inline Variable",
      },
      -- Extract block supports visual mode
      {
        "<leader>rb",
        function()
          require("refactoring").refactor("Extract Block")
        end,
        mode = "x",
        desc = "Extract Block",
      },
      {
        "<leader>rbf",
        function()
          require("refactoring").refactor("Extract Block To File")
        end,
        mode = "x",
        desc = "Extract Block To File",
      },
      -- Refactoring menu
      {
        "<leader>rr",
        function()
          require("refactoring").select_refactor()
        end,
        mode = { "n", "x" },
        desc = "Select Refactoring",
      },
      -- Debug operations
      {
        "<leader>rp",
        function()
          require("refactoring").debug.printf({ below = false })
        end,
        desc = "Debug Print",
      },
      {
        "<leader>rd",
        function()
          require("refactoring").debug.print_var()
        end,
        mode = { "x", "n" },
        desc = "Debug Print Variable",
      },
      {
        "<leader>rc",
        function()
          require("refactoring").debug.cleanup({})
        end,
        desc = "Debug Cleanup",
      },
    },
    config = function()
      require("refactoring").setup({
        -- Prompt for function name
        prompt_func_return_type = {
          go = true,
          java = true,
          cpp = true,
          c = true,
          h = true,
          hpp = true,
          cxx = true,
        },
        -- Prompt for function parameters
        prompt_func_param_type = {
          go = true,
          java = true,
          cpp = true,
          c = true,
          h = true,
          hpp = true,
          cxx = true,
        },
        -- Customized printf statements for debugging
        printf_statements = {
          -- Add custom printf statements for different languages
          typescript = {
            'console.log("DEBUG %s:", %s)',
          },
          javascript = {
            'console.log("DEBUG %s:", %s)',
          },
          go = {
            'fmt.Printf("DEBUG %s: %%v\\n", %s)',
          },
          python = {
            'print(f"DEBUG %s: {%s}")',
          },
          rust = {
            'println!("DEBUG %s: {:?}", %s);',
          },
        },
        -- Customized print variable statements
        print_var_statements = {
          typescript = {
            'console.log("DEBUG %s:", %s)',
          },
          javascript = {
            'console.log("DEBUG %s:", %s)',
          },
          go = {
            'fmt.Printf("DEBUG %s: %%v\\n", %s)',
          },
          python = {
            'print(f"DEBUG %s: {%s}")',
          },
          rust = {
            'println!("DEBUG %s: {:?}", %s);',
          },
        },
        -- Extract function setup
        extract_var_statements = {
          typescript = {
            "const %s = %s",
          },
          javascript = {
            "const %s = %s",
          },
          go = {
            "%s := %s",
          },
          python = {
            "%s = %s",
          },
          rust = {
            "let %s = %s;",
          },
        },
      })

      -- Create a telescope picker for refactoring options
      local function telescope_refactoring()
        local pickers = require("telescope.pickers")
        local finders = require("telescope.finders")
        local conf = require("telescope.config").values
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")

        local refactors = {
          { name = "Extract Function", mode = "x", cmd = "Extract Function" },
          { name = "Extract Function To File", mode = "x", cmd = "Extract Function To File" },
          { name = "Extract Variable", mode = "x", cmd = "Extract Variable" },
          { name = "Extract Block", mode = "x", cmd = "Extract Block" },
          { name = "Extract Block To File", mode = "x", cmd = "Extract Block To File" },
          { name = "Inline Variable", mode = "n", cmd = "Inline Variable" },
        }

        pickers
          .new({}, {
            prompt_title = "Refactoring Options",
            finder = finders.new_table({
              results = refactors,
              entry_maker = function(entry)
                return {
                  value = entry,
                  display = entry.name .. " (" .. entry.mode .. ")",
                  ordinal = entry.name,
                }
              end,
            }),
            sorter = conf.generic_sorter({}),
            attach_mappings = function(prompt_bufnr, map)
              actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                if selection then
                  require("refactoring").refactor(selection.value.cmd)
                end
              end)
              return true
            end,
          })
          :find()
      end

      -- Optional: Add telescope integration
      vim.keymap.set({ "n", "x" }, "<leader>rR", telescope_refactoring, { desc = "Telescope Refactoring" })
    end,
  },
}