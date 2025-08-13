-- Global UI settings configuration
local M = {}

M.setup = function()
  -- Set global UI options for consistency
  vim.o.pumheight = 10 -- Popup menu height
  vim.o.pumblend = 0 -- No transparency in popup menu
  vim.o.winblend = 0 -- No transparency in floating windows
  
  -- Consistent border styles across all plugins
  vim.g.border_style = "rounded"
  
  -- Set diagnostic signs with consistent style
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "󰌵" },
    { name = "DiagnosticSignInfo", text = "" },
  }
  
  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end
  
  -- Consistent floating window configuration
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
    max_width = 80,
    max_height = 30,
  })
  
  -- Signature help is disabled globally and handled manually via Ctrl+k
  -- See keymaps.lua for custom signature help implementation
  
  -- Ensure consistent window separators
  vim.opt.fillchars = {
    foldopen = "",
    foldclose = "",
    fold = " ",
    foldsep = " ",
    diff = "╱",
    eob = " ",
    horiz = "━",
    horizup = "┻",
    horizdown = "┳",
    vert = "┃",
    vertleft = "┫",
    vertright = "┣",
    verthoriz = "╋",
  }
  
  -- Set up autocmd to ensure UI consistency after colorscheme changes
  vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
      -- Ensure borders are visible
      vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
      vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
      vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "FloatBorder" })
      vim.api.nvim_set_hl(0, "WhichKeyBorder", { link = "FloatBorder" })
      vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "FloatBorder" })
    end,
  })
end

return M