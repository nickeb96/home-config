local wezterm = require("wezterm")
local config = {}

config.window_decorations = "RESIZE | INTEGRATED_BUTTONS"
config.window_padding = {
  top = "26pt",
  left = "6pt",
  right = "6pt",
  bottom = "6pt",
}
config.enable_tab_bar = false

config.audible_bell = "Disabled"

config.initial_cols = 120
config.initial_rows = 42

config.default_cursor_style = "SteadyUnderline"

local font_name = "SauceCodePro Nerd Font"
config.font = wezterm.font(font_name)
config.font_size = 15
config.bold_brightens_ansi_colors = false
config.font_rules = {
  {
    intensity = "Normal",
    italic = false,
    font = wezterm.font(font_name, { weight = "Regular" }),
  },
  {
    intensity = "Normal",
    italic = true,
    font = wezterm.font(font_name, { weight = "Regular", style = "Italic" }),
  },
  {
    intensity = "Bold",
    italic = false,
    font = wezterm.font(font_name, { weight = "Bold" }),
  },
  {
    intensity = "Bold",
    italic = true,
    font = wezterm.font(font_name, { weight = "Bold", style = "Italic" }),
  },
  {
    intensity = "Half",
    italic = false,
    font = wezterm.font("Victor Mono", { weight = "Light" }),
  },
  {
    intensity = "Half",
    italic = true,
    font = wezterm.font("Victor Mono", { weight = "Regular", style = "Italic" }),
  },
}

config.color_scheme = "eden-phoenix"

config.default_prog = {"/opt/homebrew/bin/fish"}

return config
