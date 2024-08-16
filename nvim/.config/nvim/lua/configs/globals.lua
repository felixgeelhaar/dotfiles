---@class configs.globals

local M = {}

function M.root_dir(opts)
	opts = vim.tbl_extend("force", {
		cwd = false,
		subdirectory = true,
		parent = true,
		other = true,
		icon = "󱉭 ",
		-- color = LazyVim.ui.fg("Special"),
	}, opts or {})
end

local icons = {
	misc = {
		dots = "󰇘",
	},
	ft = {
		octo = "",
	},
	dap = {
		Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
		Breakpoint = " ",
		BreakpointCondition = " ",
		BreakpointRejected = { " ", "DiagnosticError" },
		LogPoint = ".>",
	},
	diagnostics = {
		Error = " ",
		Warn = " ",
		Hint = " ",
		Info = " ",
	},
	git = {
		added = " ",
		modified = " ",
		removed = " ",
	},
	kinds = {
		Array = " ",
		Boolean = "󰨙 ",
		Class = " ",
		Codeium = "󰘦 ",
		Color = " ",
		Control = " ",
		Collapsed = " ",
		Constant = "󰏿 ",
		Constructor = " ",
		Copilot = " ",
		Enum = " ",
		EnumMember = " ",
		Event = " ",
		Field = " ",
		File = " ",
		Folder = " ",
		Function = "󰊕 ",
		Interface = " ",
		Key = " ",
		Keyword = " ",
		Method = "󰊕 ",
		Module = " ",
		Namespace = "󰦮 ",
		Null = " ",
		Number = "󰎠 ",
		Object = " ",
		Operator = " ",
		Package = " ",
		Property = " ",
		Reference = " ",
		Snippet = " ",
		String = " ",
		Struct = "󰆼 ",
		TabNine = "󰏚 ",
		Text = " ",
		TypeParameter = " ",
		Unit = " ",
		Value = " ",
		Variable = "󰀫 ",
	},
}

---@return {fg?:string}?
function M.fg(name)
	local color = M.color(name)
	return color and { fg = color } or nil
end

---@param name string
---@param bg? boolean
---@return string?
function M.color(name, bg)
	---@type {foreground?:number}?
	local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name, link = false })
		or vim.api.nvim_get_hl_by_name(name, true)
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

Configs = {
	M,
	icons = icons,
}
