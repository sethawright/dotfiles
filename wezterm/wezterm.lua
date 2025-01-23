-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

local function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Dark"
end

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "github_dark_dimmed"
	else
		return "github_light"
	end
end

local function is_vim(pane)
	-- this is set by the plugin, and unset on ExitPre in Neovim
	return pane:get_user_vars().IS_NVIM == "true"
end

local direction_keys = {
	Left = "h",
	Down = "j",
	Up = "k",
	Right = "l",
	-- reverse lookup
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

config.use_fancy_tab_bar = false
config.font = wezterm.font("SFMono Nerd Font", { weight = "Regular", stretch = "Normal", style = "Normal" }) -- (AKA: SF Mono) /Users/sethwright/Library/Fonts/SFMono Regular Nerd Font Complete.otf, CoreText
config.default_prog = { "/opt/homebrew/bin/fish", "-l", "-c", "tmux attach -t home || tmux new-session -s home" }
config.font_size = 13.0
config.line_height = 1.4
-- config.leader = { key = "f", mods = "CTRL", timeout_milliseconds = 1000 }
config.color_scheme_dirs = { "/Users/sethwright/.config/wezterm/themes/" }
config.color_scheme = scheme_for_appearance(get_appearance())
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = true
config.disable_default_key_bindings = true
config.window_padding = {
	left = 40,
	right = 40,
}
config.keys = {
	{
		key = "Enter",
		mods = "CMD",
		action = wezterm.action.ToggleFullScreen,
	},
	{ key = "Copy", mods = "NONE", action = wezterm.action.CopyTo("Clipboard") },
	{ key = "Paste", mods = "NONE", action = wezterm.action.PasteFrom("Clipboard") },
	{ key = "c", mods = "SUPER", action = wezterm.action.CopyTo("Clipboard") },
	{ key = "v", mods = "SUPER", action = wezterm.action.PasteFrom("Clipboard") },
	{ key = "h", mods = "SHIFT|CTRL", action = act.HideApplication },
	{ key = "h", mods = "SUPER", action = act.HideApplication },
	{ key = "l", mods = "SHIFT|CTRL", action = act.ShowDebugOverlay },
	{ key = "+", mods = "SHIFT|CTRL", action = act.IncreaseFontSize },
	{ key = "+", mods = "SUPER", action = act.IncreaseFontSize },
	{ key = "-", mods = "SHIFT|CTRL", action = act.DecreaseFontSize },
	{ key = "-", mods = "SUPER", action = act.DecreaseFontSize },
	{ key = "0", mods = "SUPER", action = act.ResetFontSize },
	{ key = "q", mods = "SUPER", action = act.QuitApplication },
	{ key = "r", mods = "SHIFT|CTRL", action = act.ReloadConfiguration },
	{ key = "p", mods = "SHIFT|CTRL", action = act.ActivateCommandPalette },

	-- manage splits
	{
		mods = "SUPER",
		key = "}",
		action = wezterm.action.Multiple({
			wezterm.action.SendKey({ key = "f", mods = "CTRL" }),
			wezterm.action.SendKey({ key = "n" }),
		}),
	},
	{
		mods = "SHIFT|SUPER",
		key = "}",
		action = wezterm.action.Multiple({
			wezterm.action.SendKey({ key = "f", mods = "CTRL" }),
			wezterm.action.SendKey({ key = "n" }),
		}),
	},
	{
		mods = "SUPER",
		key = "{",
		action = wezterm.action.Multiple({
			wezterm.action.SendKey({ key = "f", mods = "CTRL" }),
			wezterm.action.SendKey({ key = "p" }),
		}),
	},
	{
		mods = "SHIFT|SUPER",
		key = "{",
		action = wezterm.action.Multiple({
			wezterm.action.SendKey({ key = "f", mods = "CTRL" }),
			wezterm.action.SendKey({ key = "p" }),
		}),
	},
	{
		mods = "SUPER",
		key = "n",
		action = wezterm.action.Multiple({
			wezterm.action.SendKey({ key = "f", mods = "CTRL" }),
			wezterm.action.SendKey({ key = "c" }),
		}),
	},
	{
		mods = "SUPER",
		key = "w",
		action = wezterm.action.SendKey({ key = "≈" }),
	},
	{
		mods = "SUPER",
		key = "r",
		action = wezterm.action.SendKey({ key = "÷" }),
	},

	-- zooming
	{
		mods = "SUPER",
		key = "z",
		action = wezterm.action.Multiple({
			wezterm.action.SendKey({ key = "f", mods = "CTRL" }),
			wezterm.action.SendKey({ key = "z" }),
		}),
	},
}

return config
