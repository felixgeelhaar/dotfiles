local function augroup(name)
  return vim.api.nvim_create_augroup("ghf_" .. name, { clear = true })
end

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Close configured filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "help",
    "lspinfo",
    "man",
    "qf",
    "query",
    "spectre_panel",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Disable miniindentscope on filetype
-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = {
--     'alpha',
--     'dashboard',
--     'fzf',
--     'help',
--     'lazy',
--     'lazyterm',
--     'mason',
--     'neo-tree',
--     'notify',
--     'toggleterm',
--     'Trouble',
--     'trouble',
--   },
--   callback = function()
--     vim.b.miniindentscope_disable = true
--   end,
-- })
