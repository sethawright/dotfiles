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

local function split_nav(resize_or_move, key)
	return {
		key = key,
		mods = resize_or_move == "resize" and "SUPER|CTRL" or "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = resize_or_move == "resize" and "SUPER|CTRL" or "CTRL" },
				}, pane)
			else
				if resize_or_move == "resize" then
					win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
				end
			end
		end),
	}
end

config.use_fancy_tab_bar = false
config.font = wezterm.font("SFMono Nerd Font", { weight = "Regular", stretch = "Normal", style = "Normal" }) -- (AKA: SF Mono) /Users/sethwright/Library/Fonts/SFMono Regular Nerd Font Complete.otf, CoreText
config.default_prog = { "/opt/homebrew/bin/fish", "-l", "-c", "tmux attach -t home || tmux new-session -s home" }
config.font_size = 16.0
config.line_height = 1.5
config.leader = { key = "d", mods = "CTRL", timeout_milliseconds = 1000 }
config.color_scheme_dirs = { "/Users/sethwright/.config/wezterm/themes/" }
config.color_scheme = scheme_for_appearance(get_appearance())
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.keys = {
	{
		key = "Enter",
		mods = "CMD",
		action = wezterm.action.ToggleFullScreen,
	},
	{
		key = "r",
		mods = "SUPER",
		action = wezterm.action.PromptInputLine({
			description = "Name:",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},

	-- manage splits
	{
		mods = "SUPER",
		key = "]",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "SUPER",
		key = "n",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		mods = "SUPER",
		key = "\\",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "SUPER",
		key = "w",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},
	{
		mods = "LEADER",
		key = "x",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},

	-- zooming
	{
		mods = "LEADER",
		key = "z",
		action = wezterm.action.TogglePaneZoomState,
	},
	{
		mods = "SUPER",
		key = "z",
		action = wezterm.action.TogglePaneZoomState,
	},

	-- rotate panes
	{
		mods = "LEADER",
		key = "Space",
		action = wezterm.action.RotatePanes("Clockwise"),
	},

	-- show the pane selection mode, but have it swap the active and selected panes
	{
		mods = "LEADER",
		key = "0",
		action = wezterm.action.PaneSelect({ mode = "SwapWithActive" }),
	},
	{
		key = "Enter",
		mods = "LEADER",
		action = wezterm.action.ActivateCopyMode,
	},

	-- move between split panes
	-- split_nav("move", "h"),
	-- split_nav("move", "k"),
	-- split_nav("move", "j"),
	-- split_nav("move", "l"),

	-- resize panes
	-- split_nav("resize", "h"),
	-- split_nav("resize", "j"),
	-- split_nav("resize", "k"),
	-- split_nav("resize", "l"),
}

return config
