return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = true,
        motions = true,
        text_objects = true,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
    },
    key_labels = {
      ["<space>"] = "SPC",
      ["<leader>"] = "SPC",
      ["<cr>"] = "RET",
      ["<tab>"] = "TAB",
    },
    icons = {
      breadcrumb = "»",
      separator = "➜",
      group = "+",
    },
    window = {
      border = "rounded",
      padding = { 1, 2 },
      winblend = 0,
    },
    layout = {
      height = { min = 4, max = 25 },
      width = { min = 20, max = 50 },
      spacing = 3,
      align = "center",
    },
    show_help = true,
    show_keys = true,
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    -- Safely require mini.icons
    local MiniIcons = nil
    local has_mini_icons = pcall(require, "mini.icons")
    if has_mini_icons then
      MiniIcons = require("mini.icons")
    end

    -- Ensure the icons we're trying to use actually exist
    local function get_icon(category, name)
      if not MiniIcons then
        return "" -- Return empty string if mini.icons is not available
      end

      local ok, icon = pcall(MiniIcons.get, category, name)
      if not ok then
        return ""     -- Return empty string as fallback
      end
      return icon .. " " -- Add a space after the icon for better visual appearance
    end

    -- Register all mappings with which-key using the new syntax
    wk.add({
      -- AI Assistant group
      { "<leader>a",  group = get_icon("ui", "robot") .. "[A]I Assistant" },
      { "<leader>ac", "<cmd>CodeCompanionChat<cr>",                          desc = "Chat with AI" },

      -- AI code actions subgroup
      { "<leader>ac", group = get_icon("ui", "robot") .. "AI [C]ode Actions" },
      {
        "<leader>ace",
        function()
          require("codecompanion").prompt("explain_code")
        end,
        desc = "Explain Code",
      },
      {
        "<leader>aco",
        function()
          require("codecompanion").prompt("optimize_code")
        end,
        desc = "Optimize Code",
      },
      {
        "<leader>acr",
        function()
          require("codecompanion").prompt("refactor_code")
        end,
        desc = "Refactor Code",
      },
      {
        "<leader>act",
        function()
          require("codecompanion").prompt("generate_tests")
        end,
        desc = "Generate Tests",
      },
      {
        "<leader>acd",
        function()
          require("codecompanion").prompt("document_code")
        end,
        desc = "Document Code",
      },
      {
        "<leader>acf",
        function()
          require("codecompanion").prompt("fix_issues")
        end,
        desc = "Fix Code",
      },

      -- Buffer group
      { "<leader>b",   group = get_icon("filetype", "Readme.md") .. "[B]uffer" },
      { "<leader>bd",  "<cmd>bdelete<cr>",                                            desc = "Delete Buffer" },
      { "<leader>bn",  "<cmd>bnext<cr>",                                              desc = "Next Buffer" },
      { "<leader>bp",  "<cmd>bprevious<cr>",                                          desc = "Previous Buffer" },
      { "<leader>bs",  "<cmd>w<cr>",                                                  desc = "Save Buffer" },

      -- Code group
      { "<leader>c",   group = get_icon("directory", "src") .. "[C]ode" },
      { "<leader>ca",  "<cmd>lua vim.lsp.buf.code_action()<cr>",                      desc = "Code Action" },
      { "<leader>cf",  "<cmd>lua vim.lsp.buf.format()<cr>",                           desc = "Format Code" },

      -- Code Refactoring subgroup
      { "<leader>cr",  group = "Refactoring" },
      { "<leader>crr", "<cmd>lua vim.lsp.buf.rename()<cr>",                           desc = "Rename Symbol" },
      { "<leader>cre", "<cmd>lua vim.lsp.buf.references()<cr>",                       desc = "Extract Variable" },

      -- Code Symbols subgroup
      { "<leader>cs",  group = "Symbols" },
      { "<leader>cso", "<cmd>SymbolsOutline<cr>",                                     desc = "Outline" },
      { "<leader>css", "<cmd>Telescope lsp_document_symbols<cr>",                     desc = "Document Symbols" },

      -- Code Diagnostics subgroup
      { "<leader>cd",  group = "Diagnostics" },
      { "<leader>cdl", "<cmd>lua vim.diagnostic.open_float()<cr>",                    desc = "Line Diagnostics" },
      { "<leader>cdn", "<cmd>lua vim.diagnostic.goto_next()<cr>",                     desc = "Next Diagnostic" },
      { "<leader>cdp", "<cmd>lua vim.diagnostic.goto_prev()<cr>",                     desc = "Previous Diagnostic" },

      -- Debug group
      { "<leader>d",   group = get_icon("lsp", "class") .. "[D]ebug" },
      { "<leader>db",  "<cmd>lua require('dap').toggle_breakpoint()<cr>",             desc = "Toggle Breakpoint" },
      { "<leader>dc",  "<cmd>lua require('dap').continue()<cr>",                      desc = "Continue" },
      { "<leader>ds",  "<cmd>lua require('dap').step_over()<cr>",                     desc = "Step Over" },

      -- Explorer group
      { "<leader>e",   group = get_icon("directory", "") .. "[E]xplorer" },
      { "<leader>ee",  "<cmd>Neotree toggle<cr>",                                     desc = "Toggle Explorer" },
      { "<leader>ef",  "<cmd>Neotree reveal<cr>",                                     desc = "Find File in Explorer" },

      -- Find/File group
      { "<leader>f",   group = get_icon("lsp", "file") .. "[F]ind/[F]ile" },
      { "<leader>ff",  "<cmd>Telescope find_files<cr>",                               desc = "Find Files" },
      { "<leader>fr",  "<cmd>Telescope oldfiles<cr>",                                 desc = "Recent Files" },
      { "<leader>fg",  "<cmd>Telescope live_grep<cr>",                                desc = "Grep" },

      -- Find Usages subgroup
      { "<leader>fu",  group = "[U]sages" },
      { "<leader>fur", "<cmd>Telescope lsp_references<cr>",                           desc = "Find References" },
      { "<leader>fui", "<cmd>Telescope lsp_implementations<cr>",                      desc = "Find Implementations" },

      -- Git group
      { "<leader>g",   group = get_icon("filetype", ".git") .. "[G]it" },
      { "<leader>gs",  "<cmd>Telescope git_status<cr>",                               desc = "Status" },
      { "<leader>gc",  "<cmd>Telescope git_commits<cr>",                              desc = "Commits" },
      { "<leader>gb",  "<cmd>Telescope git_branches<cr>",                             desc = "Branches" },
      { "<leader>gg",  "<cmd>LazyGit<cr>",                                            desc = "LazyGit" },
      { "<leader>gd",  "<cmd>DiffviewOpen<cr>",                                       desc = "Diff View" },
      { "<leader>gD",  "<cmd>DiffviewOpen origin/develop...HEAD<cr>",                 desc = "Diff with develop" },

      -- Lazy group
      { "<leader>l",   group = get_icon("filetype", "lazy") .. "[L]azy" },
      { "<leader>ll",  "<cmd>Lazy<cr>",                                               desc = "Open Lazy" },
      { "<leader>ls",  "<cmd>Lazy sync<cr>",                                          desc = "Sync Plugins" },
      { "<leader>lu",  "<cmd>Lazy update<cr>",                                        desc = "Update Plugins" },

      -- Noice group
      { "<leader>n",   group = get_icon("file", "Changelog") .. "[N]oice" },
      { "<leader>nn",  "<cmd>Noice<cr>",                                              desc = "Noice" },
      { "<leader>nh",  "<cmd>Noice history<cr>",                                      desc = "History" },
      { "<leader>nl",  "<cmd>Noice last<cr>",                                         desc = "Last Message" },

      -- Overseer group
      { "<leader>o",   group = get_icon("directory", "build") .. "[O]verseer" },
      { "<leader>oo",  "<cmd>OverseerToggle<cr>",                                     desc = "Toggle Overseer" },
      { "<leader>or",  "<cmd>OverseerRun<cr>",                                        desc = "Run Task" },

      -- Search group
      { "<leader>s",   group = get_icon("lsp", "symbol-array") .. "[S]earch" },
      { "<leader>ss",  "<cmd>Telescope current_buffer_fuzzy_find<cr>",                desc = "Search in Buffer" },
      { "<leader>sp",  "<cmd>Telescope live_grep<cr>",                                desc = "Search in Project" },

      -- Test group
      { "<leader>t",   group = get_icon("directory", "test") .. "[T]est" },
      { "<leader>tt",  "<cmd>lua require('neotest').run.run()<cr>",                   desc = "Run Test" },
      { "<leader>tf",  "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", desc = "Run File" },

      -- Workspace group
      { "<leader>w",   group = get_icon("directory", "workspace") .. "[W]orkspace" },
      { "<leader>wa",  "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>",             desc = "Add Folder" },
      { "<leader>wr",  "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>",          desc = "Remove Folder" },
      {
        "<leader>wl",
        "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>",
        desc = "List Folders",
      },

      -- Quickfix group
      { "<leader>x",  group = get_icon("filetype", "mason") .. "quickfi[X]" },
      { "<leader>xi", "<cmd>Mason<cr>",                                        desc = "Mason Installer" },
      { "<leader>xu", "<cmd>MasonUpdate<cr>",                                  desc = "Mason Update" },

      -- Common groups for non-leader keys
      { "g",          group = get_icon("lsp", "go-to-definition") .. "[G]o to" },
      { "z",          group = get_icon("ui", "fold") .. "[Z] Fold" },
      { "[",          group = get_icon("ui", "arrow-left") .. "Previous" },
      { "]",          group = get_icon("ui", "arrow-right") .. "Next" },
    })
  end,
}
