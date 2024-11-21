-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Miscellaneous
-- config.tab_bar_at_bottom = true
config.automatically_reload_config = true

-- Window
config.initial_cols = 180
config.initial_rows = 40
config.window_padding = {
  left = 20,
  bottom = 10,
  top = 10,
  right = 20,
}

-- Font
config.font = wezterm.font 'MesloLGL Nerd Font Mono'
config.font_size = 16

-- Cursor
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.default_cursor_style = "BlinkingBlock"

-- Color Scheme
config.color_scheme = 'Catppuccin Mocha'

return config
