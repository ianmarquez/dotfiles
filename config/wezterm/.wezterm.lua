-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Miscellaneous
config.automatically_reload_config = true
config.line_height = 1.05
config.hide_mouse_cursor_when_typing = true
config.underline_position = "-4pt"

-- Tab bar
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

-- Window
config.initial_cols = 180
config.initial_rows = 40
config.window_padding = {
  left = 0,
  bottom = 0,
  top = 0,
  right = 0,
}
config.window_background_opacity = 0.9
config.macos_window_background_blur = 85
config.window_decorations = "TITLE | RESIZE"

-- Font
config.font = wezterm.font 'JetBrainsMono Nerd Font Mono'
config.font_size = 17

-- Cursor
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.default_cursor_style = "BlinkingBlock"

-- Color Scheme
config.color_scheme = 'Catppuccin Mocha'

return config
