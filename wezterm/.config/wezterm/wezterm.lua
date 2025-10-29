-- Pull in the wezterm API
local wezterm = require("wezterm")

-- locals
local config = wezterm.config_builder()
local act = wezterm.action

-- Configuration settings
config.automatically_reload_config = true
config.status_update_interval = 500

-- Terminal features for Neovim and development
config.enable_kitty_graphics = true  -- Support for image rendering
-- config.term = "wezterm"  -- DISABLED: Causes character duplication on macOS
config.scrollback_lines = 10000  -- Large scrollback for debugging
config.enable_scroll_bar = false  -- Minimal UI

-- True color support (essential for Neovim themes)
config.color_scheme_dirs = {}  -- Use built-in color schemes

-- Appearance with Rose Pine Moon theme
config.color_scheme = "rose-pine-moon"
config.window_background_opacity = 0.95
config.macos_window_background_blur = 20

-- Additional Rose Pine Moon styling
config.colors = {
	-- Rose Pine Moon custom colors
	-- More muted, darker than Catppuccin

	-- Cursor colors (using Rose Pine Moon colors)
	cursor_bg = '#ea9a97', -- Rose
	cursor_fg = '#232136', -- Base
	cursor_border = '#ea9a97', -- Rose

	-- Selection colors
	selection_fg = '#e0def4', -- Text
	selection_bg = '#44415a', -- Highlight Med
}

-- ============================================================================
-- ALTERNATIVE THEME: Catppuccin Macchiato (Commented Out)
-- ============================================================================
-- Uncomment the lines below and comment out Rose Pine Moon above to switch back
--
-- config.color_scheme = "Catppuccin Macchiato"
-- config.colors = {
-- 	-- Cursor colors (using Catppuccin Macchiato colors)
-- 	cursor_bg = '#f4dbd6', -- Rosewater
-- 	cursor_fg = '#24273a', -- Base
-- 	cursor_border = '#f4dbd6', -- Rosewater
--
-- 	-- Selection colors
-- 	selection_fg = '#24273a', -- Base
-- 	selection_bg = '#b7bdf8', -- Lavender
-- }

-- Font configuration with fallbacks
config.font = wezterm.font_with_fallback({
	"JetBrains Mono",
	"SF Mono",
	"Menlo",
})
config.font_size = 14.0

-- Cursor configuration optimized for Neovim
config.cursor_thickness = 2.0
config.default_cursor_style = "SteadyBlock"
config.cursor_blink_rate = 0  -- Disable blinking for better focus
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

-- Allow Neovim to control cursor shape (block, bar, underline)
-- Neovim will send escape sequences to change cursor based on mode
config.animation_fps = 60
config.max_fps = 60

-- Window
config.enable_tab_bar = false
config.window_decorations = "TITLE | RESIZE"
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- Behavior
config.window_close_confirmation = "NeverPrompt"
config.exit_behavior = "CloseOnCleanExit"

-- Tab configuration (disabled)
-- config.tab_bar_at_bottom = true
-- config.use_fancy_tab_bar = false
-- config.tab_max_width = 32
-- config.show_tab_index_in_tab_bar = false

-- Configure keys
config.leader = { key = "s", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = {
	-- Disable default assignments
	{
		key = "m",
		mods = "CMD",
		action = act.DisableDefaultAssignment,
	},
	
	-- Pane splitting
	{
		mods = "LEADER",
		key = "|",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "-",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	
	-- Pane navigation (vim-style)
	{
		mods = "LEADER",
		key = "h",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		mods = "LEADER",
		key = "j",
		action = act.ActivatePaneDirection("Down"),
	},
	{
		mods = "LEADER",
		key = "k",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		mods = "LEADER",
		key = "l",
		action = act.ActivatePaneDirection("Right"),
	},
	
	-- Pane resizing
	{
		mods = "LEADER",
		key = "LeftArrow",
		action = act.AdjustPaneSize({ "Left", 5 }),
	},
	{
		mods = "LEADER",
		key = "RightArrow",
		action = act.AdjustPaneSize({ "Right", 5 }),
	},
	{
		mods = "LEADER",
		key = "DownArrow",
		action = act.AdjustPaneSize({ "Down", 5 }),
	},
	{
		mods = "LEADER",
		key = "UpArrow",
		action = act.AdjustPaneSize({ "Up", 5 }),
	},
	
	-- Pane closing
	{
		mods = "LEADER",
		key = "x",
		action = act.CloseCurrentPane({ confirm = true }),
	},
	
	-- Window management (replaces tab functionality)
	{
		key = "n",
		mods = "CMD",
		action = act.SpawnWindow,
	},
	{
		key = "w",
		mods = "LEADER",
		action = act.SpawnWindow,
	},
	
	-- Additional functionality
	{
		key = "r",
		mods = "LEADER",
		action = act.ReloadConfiguration,
	},
	{
		key = "z",
		mods = "LEADER",
		action = act.TogglePaneZoomState,
	},
	{
		key = "[",
		mods = "LEADER",
		action = act.ActivateCopyMode,
	},

	-- Developer-friendly shortcuts
	{
		key = "k",
		mods = "CMD",
		action = act.ClearScrollback("ScrollbackAndViewport"),
	},
	{
		key = "f",
		mods = "CMD",
		action = act.Search({ CaseSensitiveString = "" }),
	},
	{
		key = "+",
		mods = "CMD",
		action = act.IncreaseFontSize,
	},
	{
		key = "-",
		mods = "CMD",
		action = act.DecreaseFontSize,
	},
	{
		key = "0",
		mods = "CMD",
		action = act.ResetFontSize,
	},
	{
		key = "c",
		mods = "CMD",
		action = act.CopyTo("Clipboard"),
	},
	{
		key = "v",
		mods = "CMD",
		action = act.PasteFrom("Clipboard"),
	},
}

-- Mouse configuration
config.mouse_bindings = {
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = act.OpenLinkAtMouseCursor,
	},
}

-- Window title formatting to show current folder
-- Enhanced contextual window title for developer workflows
wezterm.on("format-window-title", function(tab, pane, tabs, panes, config)
	local cwd = pane.current_working_dir
	local title_parts = {}

	if cwd then
		-- Extract folder/project name
		local folder_name = cwd.file_path:match("([^/]+)/?$") or cwd.file_path
		table.insert(title_parts, folder_name)

		-- Detect project type from common project files
		local project_type = nil
		local cwd_path = cwd.file_path

		-- Check for project files to determine type
		local function file_exists(path)
			local f = io.open(path, "r")
			if f ~= nil then
				io.close(f)
				return true
			end
			return false
		end

		-- Node.js project
		if file_exists(cwd_path .. "/package.json") then
			project_type = "Node.js"
		-- Python project
		elseif file_exists(cwd_path .. "/requirements.txt") or
		       file_exists(cwd_path .. "/pyproject.toml") or
		       file_exists(cwd_path .. "/setup.py") then
			project_type = "Python"
		-- Go project
		elseif file_exists(cwd_path .. "/go.mod") then
			project_type = "Go"
		-- Rust project
		elseif file_exists(cwd_path .. "/Cargo.toml") then
			project_type = "Rust"
		-- Ruby project
		elseif file_exists(cwd_path .. "/Gemfile") then
			project_type = "Ruby"
		-- PHP project
		elseif file_exists(cwd_path .. "/composer.json") then
			project_type = "PHP"
		-- Java/Maven project
		elseif file_exists(cwd_path .. "/pom.xml") then
			project_type = "Java/Maven"
		-- Kotlin/Gradle project
		elseif file_exists(cwd_path .. "/build.gradle.kts") then
			project_type = "Kotlin"
		end

		if project_type then
			table.insert(title_parts, "[" .. project_type .. "]")
		end

		-- Get git branch if in a git repository
		local success, git_branch = pcall(function()
			local handle = io.popen("cd " .. cwd_path .. " && git branch --show-current 2>/dev/null")
			if handle then
				local branch = handle:read("*a")
				handle:close()
				-- Trim whitespace
				branch = branch:gsub("^%s*(.-)%s*$", "%1")
				if branch and branch ~= "" then
					return branch
				end
			end
			return nil
		end)

		if success and git_branch then
			table.insert(title_parts, "(" .. git_branch .. ")")
		end
	end

	-- Get the active foreground process name
	local process_name = pane.foreground_process_name
	if process_name then
		-- Extract just the process name without path
		process_name = process_name:match("([^/]+)$") or process_name
		-- Add process indicator for common dev tools
		if process_name == "nvim" or process_name == "vim" then
			table.insert(title_parts, "✎ nvim")
		elseif process_name == "node" then
			table.insert(title_parts, "⬢ node")
		elseif process_name == "python" or process_name == "python3" then
			table.insert(title_parts, "🐍 python")
		elseif process_name == "cargo" or process_name == "rustc" then
			table.insert(title_parts, "🦀 rust")
		elseif process_name == "go" then
			table.insert(title_parts, "🐹 go")
		elseif process_name == "docker" or process_name == "docker-compose" then
			table.insert(title_parts, "🐳 docker")
		elseif process_name == "kubectl" or process_name == "k9s" then
			table.insert(title_parts, "☸ k8s")
		elseif process_name ~= "zsh" and process_name ~= "bash" and process_name ~= "fish" then
			-- Show other non-shell processes
			table.insert(title_parts, "▶ " .. process_name)
		end
	end

	-- Combine all parts with separator
	if #title_parts > 0 then
		return table.concat(title_parts, " ")
	else
		return "WezTerm"
	end
end)

-- Tab title formatting to show current folder (if tabs are re-enabled)
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local pane = tab.active_pane
	local cwd = pane.current_working_dir
	if cwd then
		local folder_name = cwd.file_path:match("([^/]+)/?$") or cwd.file_path
		return {
			{ Text = " " .. folder_name .. " " },
		}
	else
		return tab.active_pane.title
	end
end)

-- and finally, return the configuration to wezterm
return config
