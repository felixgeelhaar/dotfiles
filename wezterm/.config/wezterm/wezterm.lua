-- Pull in the wezterm API
local wezterm = require("wezterm")

-- locals
local config = wezterm.config_builder()
local act = wezterm.action

config = {
	automatically_reload_config = true,
	status_update_interval = 1000,

	color_scheme = "Catppuccin Macchiato",
	window_background_opacity = 1.0,
	font = wezterm.font("JetBrains Mono", { weight = "Regular" }),

	cursor_thickness = 2.0,
	default_cursor_style = "SteadyBlock",

	enable_tab_bar = false,
	window_decorations = "RESIZE",

	window_close_confirmation = "NeverPrompt",
	exit_behavior = "CloseOnCleanExit",
}

-- Configure keys
config.keys = {
	{
		key = "m",
		mods = "CMD",
		action = act.DisableDefaultAssignment,
	},
}

-- and finally, return the configuration to wezterm
return config
