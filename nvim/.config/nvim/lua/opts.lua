-- Display options
vim.opt.number = true         -- Make line numbers default
vim.opt.relativenumber = true -- Make relative line numbers default (useful for jumping around)
vim.opt.showmode = false      -- Don't show the mode, since it's already in status line
vim.opt.signcolumn = "yes"    -- Keep signcolumn on by default
vim.opt.cursorline = true     -- Show which line your cursor is on
vim.opt.list = true           -- Display whitespace
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣", eol = "¬" }
vim.opt.fillchars = {
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┫",
  vertright = "┣",
  verthoriz = "╋",
  fold = "⸱",
  foldopen = "",
  foldclose = "",
  foldsep = "│",
  diff = "╱",
  eob = " ", -- Hide end-of-buffer tildes
}
vim.opt.pumheight = 10        -- Maximum number of entries in popup menu
vim.opt.pumblend = 10         -- Popup menu transparency
vim.opt.winblend = 0          -- Window transparency (0 = opaque)

-- Editing behavior
vim.opt.mouse = "a"               -- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.clipboard = "unnamedplus" -- Sync clipboard between OS and Neovim
vim.opt.breakindent = true        -- Enable break indent
vim.opt.undofile = true           -- Save undo history
vim.opt.updatetime = 250          -- Decrease update time
vim.opt.timeoutlen = 300          -- Time in ms to wait for a mapped sequence to complete
vim.opt.inccommand = "split"      -- Preview substitutions live, as you type!

-- Search and navigation
vim.opt.ignorecase = true -- Case-insensitive searching UNLESS \C or capital in search
vim.opt.smartcase = true  -- Smart case-sensitive searching
vim.opt.hlsearch = true   -- Set highlight on search
vim.opt.incsearch = true  -- Show search matches as you type
vim.opt.scrolloff = 10    -- Minimal number of screen lines to keep above and below the cursor
vim.opt.sidescrolloff = 8 -- Minimal number of screen columns to keep to the left and right of the cursor
vim.opt.wrap = false      -- Don't wrap lines by default
vim.opt.linebreak = true  -- Break lines at word boundaries when wrap is enabled
vim.opt.showmatch = true  -- Highlight matching brackets
vim.opt.matchtime = 2     -- Time in tenths of seconds to show matching bracket

-- Window splitting
vim.opt.splitright = true -- Horizontal splits will automatically be to the right
vim.opt.splitbelow = true -- Vertical splits will automatically be below
vim.opt.equalalways = false -- Don't automatically resize windows

-- Folding
vim.opt.foldmethod = "expr"      -- Use expression-based folding (treesitter)
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldcolumn = "1"         -- Show fold column
vim.opt.foldlevel = 99           -- Start with most folds open
vim.opt.foldlevelstart = 99      -- Start with most folds open
vim.opt.foldenable = true        -- Enable folding

-- Completion and popup menus
vim.opt.completeopt = { "menu", "menuone", "noselect" } -- Better completion experience
vim.opt.shortmess:append("c")    -- Don't show completion messages
vim.opt.iskeyword:append("-")    -- Treat dash-separated words as single words

-- Performance
vim.opt.lazyredraw = false       -- Don't redraw screen during macros (set to false for modern Neovim)
vim.opt.ttyfast = true           -- Faster terminal connection
vim.opt.backup = false           -- Don't create backup files
vim.opt.writebackup = false      -- Don't create backup files
vim.opt.swapfile = false         -- Don't create swap files
vim.opt.undodir = vim.fn.expand("~/.vim/undodir") -- Centralized undo directory
vim.opt.undolevels = 10000       -- Maximum number of changes that can be undone

-- Better command line
vim.opt.cmdheight = 1            -- Command line height
vim.opt.showcmd = false          -- Don't show command in status line
vim.opt.ruler = false            -- Don't show cursor position in status line

-- Nerd font support
vim.g.have_nerd_font = true

-- Disable some built-in plugins for better performance
vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_getScript = 1
vim.g.loaded_getScriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrw = 1           -- We use neo-tree
vim.g.loaded_netrwPlugin = 1     -- We use neo-tree
vim.g.loaded_netrwSettings = 1   -- We use neo-tree
