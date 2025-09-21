local wezterm = require("wezterm")
local mux = wezterm.mux
local config = wezterm.config_builder()

-- Basic configuration
config.enable_wayland = false
config.color_scheme = "Catppuccin Mocha"
-- config.window_background_opacity = 0.75
config.window_decorations = "NONE"
config.font = wezterm.font("DepartureMono Nerd Font")

-- Tabs configuration
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.colors = {
	tab_bar = {
		active_tab = {
			bg_color = "#89dceb",
			fg_color = "#1e1e2e",
			intensity = "Bold",
		},
	},
}

config.keys = require("keybinds")

wezterm.on("gui-startup", function(cmd)
	local _, _, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

config.set_environment_variables = {
	TERM = "xterm-256color",
}

return config
