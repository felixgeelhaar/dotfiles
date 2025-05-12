-- Display options
vim.opt.number = true         -- Make line numbers default
vim.opt.relativenumber = true -- Make relative line numbers default (useful for jumping around)
vim.opt.showmode = false      -- Don't show the mode, since it's already in status line
vim.opt.signcolumn = "yes"    -- Keep signcolumn on by default
vim.opt.cursorline = true     -- Show which line your cursor is on
vim.opt.list = true           -- Display whitespace
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

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
vim.opt.scrolloff = 10    -- Minimal number of screen lines to keep above and below the cursor

-- Window splitting
vim.opt.splitright = true -- Horizontal splits will automatically be to the right
vim.opt.splitbelow = true -- Vertical splits will automatically be below

-- Nerd font support
vim.g.have_nerd_font = true

-- Uncomment if you want to use notify plugin
-- vim.notify = require 'notify'
