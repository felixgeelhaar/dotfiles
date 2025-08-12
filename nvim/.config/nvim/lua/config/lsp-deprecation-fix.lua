-- Fix for deprecated LSP functions
-- This module provides compatibility shims for deprecated LSP functions

local M = {}

M.setup = function()
  -- Replace deprecated vim.lsp.buf_get_clients with vim.lsp.get_clients
  if vim.lsp.buf_get_clients then
    vim.lsp.buf_get_clients = function(bufnr)
      return vim.lsp.get_clients({ buffer = bufnr })
    end
  end
  
  -- Replace deprecated vim.lsp.get_active_clients with vim.lsp.get_clients
  if not vim.lsp.get_active_clients then
    vim.lsp.get_active_clients = function(filter)
      return vim.lsp.get_clients(filter)
    end
  end
end

return M