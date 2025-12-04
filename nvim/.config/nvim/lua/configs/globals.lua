---@class configs.globals
--- Utility functions for project management, UI customization, and more

local M = {}

--- Determines the root directory of the current project
---@param opts table Options for determining the root directory
---@return string|nil The root directory path or nil if not found
function M.root_dir(opts)
  opts = vim.tbl_extend("force", {
    cwd = false, -- Use current working directory
    subdirectory = true, -- Allow subdirectories
    parent = true, -- Check parent directories
    other = true, -- Check other related directories
    icon = "󱉭 ", -- Icon for display purposes
  }, opts or {})

  -- Implementation to detect project root
  local path = vim.fn.expand("%:p:h")
  local root = nil

  -- Check for common project root indicators
  local root_patterns = { ".git", ".svn", "package.json", "Cargo.toml", "go.mod" }

  for _, pattern in ipairs(root_patterns) do
    local root_file = vim.fn.finddir(pattern, path .. ";")
    if root_file ~= "" then
      root = vim.fn.fnamemodify(root_file, ":p:h:h")
      break
    end

    root_file = vim.fn.findfile(pattern, path .. ";")
    if root_file ~= "" then
      root = vim.fn.fnamemodify(root_file, ":p:h")
      break
    end
  end

  -- Fallback to CWD if requested and no root found
  if not root and opts.cwd then
    root = vim.fn.getcwd()
  end

  return root
end

--- Icons used throughout the UI
local icons = {
  misc = {
    dots = "󰇘",
  },
  ft = {
    octo = "",
  },
  dap = {
    Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
    Breakpoint = " ",
    BreakpointCondition = " ",
    BreakpointRejected = { " ", "DiagnosticError" },
    LogPoint = ".>",
  },
  diagnostics = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " ",
  },
  git = {
    added = " ",
    modified = " ",
    removed = " ",
  },
  kinds = {
    Array = " ",
    Boolean = "󰨙 ",
    Class = " ",
    Codeium = "󰘦 ",
    Color = " ",
    Control = " ",
    Collapsed = " ",
    Constant = "󰏿 ",
    Constructor = " ",
    Copilot = " ",
    Enum = " ",
    EnumMember = " ",
    Event = " ",
    Field = " ",
    File = " ",
    Folder = " ",
    Function = "󰊕 ",
    Interface = " ",
    Key = " ",
    Keyword = " ",
    Method = "󰊕 ",
    Module = " ",
    Namespace = "󰦮 ",
    Null = " ",
    Number = "󰎠 ",
    Object = " ",
    Operator = " ",
    Package = " ",
    Property = " ",
    Reference = " ",
    Snippet = " ",
    String = " ",
    Struct = "󰆼 ",
    TabNine = "󰏚 ",
    Text = " ",
    TypeParameter = " ",
    Unit = " ",
    Value = " ",
    Variable = "󰀫 ",
  },
}

---@return {fg?:string}?
--- Gets the foreground color for a highlight group
---@param name string The highlight group name
function M.fg(name)
  local color = M.color(name)
  return color and { fg = color } or nil
end

---@param name string The highlight group name
---@param bg? boolean Whether to get the background color instead
---@return string? The color in hex format or nil if not found
function M.color(name, bg)
  ---@type {foreground?:number, background?:number, fg?:number, bg?:number}?
  local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
  ---@type string?
  local color = nil
  if hl then
    if bg then
      color = hl.bg or hl.background
    else
      color = hl.fg or hl.foreground
    end
  end
  return color and string.format("#%06x", color) or nil
end

-- Export icons as part of the module
M.icons = icons

-- Return the module
return M
