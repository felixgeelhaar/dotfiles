-- Pull in the wezterm API
local wezterm = require("wezterm")

-- locals
local config = wezterm.config_builder()
local act = wezterm.action

-- Configuration settings
config.automatically_reload_config = true
config.status_update_interval = 500

-- Appearance with Catppuccin theme
config.color_scheme = "Catppuccin Macchiato"
config.window_background_opacity = 0.95
config.macos_window_background_blur = 20

-- Additional Catppuccin styling
config.colors = {
	-- The default colors are defined by the Catppuccin Macchiato scheme
	-- but we can add additional customizations here if needed
	
	-- Cursor colors (using Catppuccin Macchiato colors)
	cursor_bg = '#f4dbd6', -- Rosewater
	cursor_fg = '#24273a', -- Base
	cursor_border = '#f4dbd6', -- Rosewater
	
	-- Selection colors
	selection_fg = '#24273a', -- Base
	selection_bg = '#b7bdf8', -- Lavender
}

-- Font configuration with fallbacks
config.font = wezterm.font_with_fallback({
	"JetBrains Mono",
	"SF Mono",
	"Menlo",
})
config.font_size = 14.0

-- Cursor
config.cursor_thickness = 2.0
config.default_cursor_style = "SteadyBlock"

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
wezterm.on("format-window-title", function(tab, pane, tabs, panes, config)
	local cwd = pane.current_working_dir
	if cwd then
		-- Extract just the folder name from the full path
		local folder_name = cwd.file_path:match("([^/]+)/?$") or cwd.file_path
		return "WezTerm - " .. folder_name
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
