-- Pull in the wezterm API
local wezterm = require("wezterm")

-- locals
local config = wezterm.config_builder()
local act = wezterm.action

config.status_update_interval = 1000

-- Terminal UX
config.color_scheme = "Catppuccin Macchiato"
-- config.window_background_opacity = 1.0

-- Fonts
config.font = wezterm.font("JetBrains Mono")

-- Cursor configs
config.cursor_thickness = 2.0
-- on default cursor_thickness uses underline_thickness
-- config.underline_thickness = 2.0
config.default_cursor_style = "SteadyBlock"

-- Disable Tab bar
config.enable_tab_bar = false

-- Define exit behavior (Hold | Close | CloseOnCleanExit)
config.exit_behavior = "CloseOnCleanExit"

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
