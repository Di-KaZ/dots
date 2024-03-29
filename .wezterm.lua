-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- config.font = wezterm.font 'Berkeley Mono'
config.font = wezterm.font("Monaspace Neon")

-- config.font = wezterm.font("Sophistry Sans Roguelike")
-- config.harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' }

-- 'CaskaydiaCove Nerd Font Mono'
config.font_size = 14
config.window_background_opacity = 0.8

-- For example, changing the color scheme:
config.enable_tab_bar = false
config.window_padding = {
	left = 30,
	right = 30,
	top = 30,
	bottom = 30,
}

-- config.color_scheme = 'Argonaut'
-- config.color_scheme              = 'nord'
config.color_scheme = "dracula"
config.colors = {
	background = "#191b29",
}
--
-- config.force_reverse_video_cursor = true;
-- config.colors = {
--   foreground = "#dcd7ba",
--   background = "#1f1f28",
--
--   cursor_bg = "#c8c093",
--   cursor_fg = "#c8c093",
--   cursor_border = "#c8c093",
--
--   selection_fg = "#c8c093",
--   selection_bg = "#2d4f67",
--
--   scrollbar_thumb = "#16161d",
--   split = "#16161d",
--
--   ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
--   brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
--   indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
-- };
-- and finally, return the configuration to wezterm
return config
