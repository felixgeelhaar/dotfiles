-- Custom health checks for Neovim configuration
-- Run with: :checkhealth custom

local M = {}

-- Helper function to check if executable exists
local function check_executable(name, required)
	if vim.fn.executable(name) == 1 then
		vim.health.ok(string.format("`%s` is installed", name))
		return true
	else
		if required then
			vim.health.error(string.format("`%s` not found in PATH", name))
		else
			vim.health.warn(string.format("`%s` not found (optional but recommended)", name))
		end
		return false
	end
end

-- Check if a Lua module can be loaded
local function check_module(module_name, description)
	local ok, _ = pcall(require, module_name)
	if ok then
		vim.health.ok(string.format("`%s` is available", description or module_name))
		return true
	else
		vim.health.error(string.format("`%s` failed to load", description or module_name))
		return false
	end
end

-- Main health check function
M.check = function()
	-- Neovim version check
	vim.health.start("Neovim Version")
	local version = vim.version()
	local version_str = string.format("%d.%d.%d", version.major, version.minor, version.patch)

	if version.minor >= 10 then
		vim.health.ok(string.format("Neovim %s (>= 0.10.0 required)", version_str))
	else
		vim.health.error(string.format("Neovim %s found, but >= 0.10.0 required", version_str))
	end

	-- Required executables
	vim.health.start("Required Executables")
	check_executable("git", true)
	check_executable("curl", true)

	-- Telescope dependencies
	vim.health.start("Telescope Dependencies")
	check_executable("rg", true) -- ripgrep for live_grep
	check_executable("fd", true) -- fd for find_files

	-- Optional but recommended tools
	vim.health.start("Optional Tools")
	check_executable("fzf", false)
	check_executable("delta", false) -- Git diff viewer
	check_executable("lazygit", false)

	-- Language-specific tools
	vim.health.start("Language Servers")
	check_executable("gopls", false)
	check_executable("rust-analyzer", false)
	check_executable("pyright", false)
	check_executable("lua-language-server", false)
	check_executable("typescript-language-server", false)

	-- Formatters
	vim.health.start("Code Formatters")
	check_executable("stylua", false) -- Lua
	check_executable("gofmt", false) -- Go
	check_executable("rustfmt", false) -- Rust
	check_executable("black", false) -- Python
	check_executable("prettier", false) -- JS/TS/JSON/YAML/MD

	-- Debuggers
	vim.health.start("Debuggers")
	check_executable("dlv", false) -- Go debugger (Delve)
	check_executable("codelldb", false) -- Rust/C/C++ debugger
	check_executable("node", false) -- Node.js debugger

	-- Python-specific
	vim.health.start("Python Environment")
	if check_executable("python3", false) then
		local python_version = vim.fn.system("python3 --version 2>&1")
		vim.health.info(string.format("Python version: %s", vim.trim(python_version)))

		-- Check for debugpy
		local debugpy_check = vim.fn.system("python3 -c 'import debugpy' 2>&1")
		if vim.v.shell_error == 0 then
			vim.health.ok("`debugpy` is installed (Python debugging)")
		else
			vim.health.warn("`debugpy` not found - install with: pip install debugpy")
		end
	end

	-- Mason check
	vim.health.start("Mason")
	check_module("mason", "Mason package manager")
	check_module("mason-lspconfig", "Mason LSP config")
	check_module("mason-tool-installer", "Mason tool installer")

	-- Core plugins
	vim.health.start("Core Plugins")
	check_module("lazy", "Lazy.nvim plugin manager")
	check_module("telescope", "Telescope fuzzy finder")
	check_module("nvim-treesitter", "Treesitter")
	check_module("blink.cmp", "Blink completion")

	-- LSP configuration
	vim.health.start("LSP Configuration")
	check_module("lspconfig", "LSP config")

	local clients = vim.lsp.get_clients()
	if #clients > 0 then
		vim.health.ok(string.format("%d LSP client(s) active", #clients))
		for _, client in ipairs(clients) do
			vim.health.info(string.format("  - %s", client.name))
		end
	else
		vim.health.info("No LSP clients currently active (open a code file to start LSP)")
	end

	-- DAP (Debugger)
	vim.health.start("Debug Adapter Protocol")
	check_module("dap", "nvim-dap")
	check_module("dapui", "nvim-dap-ui")

	-- Git integration
	vim.health.start("Git Integration")
	check_module("gitsigns", "Gitsigns")
	check_module("diffview", "Diffview")

	-- UI enhancements
	vim.health.start("UI Plugins")
	check_module("noice", "Noice UI")
	check_module("which-key", "Which-key")
	check_module("neo-tree", "Neo-tree file explorer")

	-- Custom configuration
	vim.health.start("Custom Configuration")

	-- Check if Nerd Font is available
	if vim.g.have_nerd_font then
		vim.health.ok("Nerd Font support enabled")
	else
		vim.health.warn("Nerd Font support not enabled (some icons may not display)")
	end

	-- Check leader key
	if vim.g.mapleader == " " then
		vim.health.ok("Leader key is set to <Space>")
	else
		vim.health.warn(string.format("Leader key is set to '%s' (expected <Space>)", vim.g.mapleader or "none"))
	end

	-- Check projects directory (if customized)
	if vim.g.projects_directory then
		local projects_dir = vim.fn.expand(vim.g.projects_directory)
		if vim.fn.isdirectory(projects_dir) == 1 then
			vim.health.ok(string.format("Custom projects directory: %s", projects_dir))
		else
			vim.health.warn(string.format("Custom projects directory not found: %s", projects_dir))
		end
	else
		vim.health.info("Using default projects directory: ~/projects")
	end

	-- Clipboard integration
	vim.health.start("Clipboard")
	if vim.fn.has("clipboard") == 1 then
		vim.health.ok("Clipboard support available")
	else
		vim.health.warn("Clipboard support not available")
	end

	-- Performance checks
	vim.health.start("Performance")

	-- Check if loader is enabled
	if vim.loader then
		vim.health.ok("Lua module loader enabled for faster startup")
	else
		vim.health.warn("Lua module loader not available (Neovim < 0.9)")
	end

	-- Check disabled providers
	local disabled_providers = {
		"python3_provider",
		"ruby_provider",
		"perl_provider",
		"node_provider",
	}

	local all_disabled = true
	for _, provider in ipairs(disabled_providers) do
		if vim.g["loaded_" .. provider] ~= 0 then
			all_disabled = false
			break
		end
	end

	if all_disabled then
		vim.health.ok("Unnecessary providers disabled for better performance")
	else
		vim.health.info("Some providers still enabled (check init.lua)")
	end
end

return M
