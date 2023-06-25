-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Dark"
end

function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "github_dark"
	else
		return "github_light"
	end
end

config.color_scheme = "AdventureTime"
config.enable_tab_bar = false

config.font = wezterm.font("SFMono Nerd Font", { weight = "Regular", stretch = "Normal", style = "Normal" }) -- (AKA: SF Mono) /Users/sethwright/Library/Fonts/SFMono Regular Nerd Font Complete.otf, CoreText
config.font_size = 12.0
config.line_height = 1.2
config.color_scheme_dirs = { "/Users/sethwright/dotfiles/wezterm-themes/" }
config.color_scheme = scheme_for_appearance(get_appearance())
config.window_close_confirmation = "NeverPrompt"

return config
