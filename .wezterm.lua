local wezterm = require("wezterm")
local action = wezterm.action

local config = wezterm.config_builder()

config.color_scheme = "Tokyo Night Moon"
config.colors = { split = "#3b4261" }

config.font = wezterm.font("BlexMono Nerd Font", { weight = "Medium" })
config.font_size = 16
config.line_height = 1.1

config.show_new_tab_button_in_tab_bar = false
config.show_close_tab_button_in_tabs = false

config.inactive_pane_hsb = {
  saturation = 1,
  brightness = 1,
}

config.keys = {
  { key = "n", mods = "CMD|SHIFT", action = action.ActivateWindowRelative(1) },
  { key = "h", mods = "CMD|SHIFT", action = action.MoveTabRelative(-1) },
  { key = "l", mods = "CMD|SHIFT", action = action.MoveTabRelative(1) },
  { key = "d", mods = "CMD", action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  {
    key = "d",
    mods = "CMD|SHIFT",
    action = action.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  { key = "w", mods = "CMD|SHIFT", action = action.CloseCurrentPane({ confirm = false }) },
  { key = "r", mods = "CMD|SHIFT", action = action.RotatePanes("Clockwise") },
  { key = "z", mods = "CTRL", action = action.TogglePaneZoomState },
  {
    key = "k",
    mods = "CMD",
    action = action.Multiple({
      action.ClearScrollback("ScrollbackAndViewport"),
      action.SendKey({ key = "l", mods = "CTRL" }),
    }),
  },
}

return config
