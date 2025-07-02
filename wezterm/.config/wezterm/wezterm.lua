-- Pull in the wezterm API
local wezterm = require("wezterm")

-- locals
local config = wezterm.config_builder()
local act = wezterm.action

-- Configuration settings
config.automatically_reload_config = true
config.status_update_interval = 500

-- Appearance  
config.color_scheme = "Catppuccin Macchiato"
config.window_background_opacity = 1.0

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
config.enable_tab_bar = true
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

-- Tab configuration
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_max_width = 32
config.show_tab_index_in_tab_bar = false

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
	
	-- Tab management
	{
		key = "t",
		mods = "LEADER",
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "1",
		mods = "LEADER",
		action = act.ActivateTab(0),
	},
	{
		key = "2",
		mods = "LEADER",
		action = act.ActivateTab(1),
	},
	{
		key = "3",
		mods = "LEADER",
		action = act.ActivateTab(2),
	},
	{
		key = "4",
		mods = "LEADER",
		action = act.ActivateTab(3),
	},
	{
		key = "5",
		mods = "LEADER",
		action = act.ActivateTab(4),
	},
	{
		key = "n",
		mods = "LEADER",
		action = act.ActivateTabRelative(1),
	},
	{
		key = "p",
		mods = "LEADER",
		action = act.ActivateTabRelative(-1),
	},
	{
		key = "&",
		mods = "LEADER",
		action = act.CloseCurrentTab({ confirm = true }),
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

-- Window title formatting to show current path
wezterm.on("format-window-title", function(tab, pane, tabs, panes, config)
	local zoomed = ""
	if tab.active_pane.is_zoomed then
		zoomed = "[Z] "
	end

	local index = ""
	if #tabs > 1 then
		index = string.format("[%d/%d] ", tab.tab_index + 1, #tabs)
	end

	return zoomed .. index .. tab.active_pane.title
end)

-- and finally, return the configuration to wezterm
return config
