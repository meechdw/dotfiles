local wezterm = require("wezterm")
local action = wezterm.action
local plugin = wezterm.plugin

local config = wezterm.config_builder()

config.font = wezterm.font("BlexMono Nerd Font", { weight = "Medium" })
config.font_size = 16
config.freetype_load_target = "Light"
config.native_macos_fullscreen_mode = true
config.show_new_tab_button_in_tab_bar = false
config.show_close_tab_button_in_tabs = false

config.color_scheme = "everforest"
config.colors = { split = "#384441" }

config.inactive_pane_hsb = {
  saturation = 1,
  brightness = 1,
}

config.keys = {
  {
    key = "f",
    mods = "CMD|CTRL",
    action = action.ToggleFullScreen,
  },
  {
    key = "n",
    mods = "CMD|SHIFT",
    action = action.ActivateWindowRelative(1),
  },
  {
    key = "k",
    mods = "CMD",
    action = action.Multiple({
      action.ClearScrollback("ScrollbackAndViewport"),
      action.SendKey({ key = "l", mods = "CTRL" }),
    }),
  },
  {
    key = "w",
    mods = "CMD",
    action = action.CloseCurrentTab({ confirm = false }),
  },
  { key = "LeftArrow", mods = "CMD|SHIFT", action = action.MoveTabRelative(-1) },
  { key = "RightArrow", mods = "CMD|SHIFT", action = action.MoveTabRelative(1) },
  {
    key = "d",
    mods = "CMD",
    action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "d",
    mods = "CMD|SHIFT",
    action = action.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "w",
    mods = "CMD|SHIFT",
    action = action.CloseCurrentPane({ confirm = false }),
  },
  {
    key = "r",
    mods = "CMD",
    action = action.RotatePanes("Clockwise"),
  },
  {
    key = "z",
    mods = "CTRL",
    action = action.TogglePaneZoomState,
  },
}

local smart_splits = plugin.require("https://github.com/mrjones2014/smart-splits.nvim")

smart_splits.apply_to_config(config, {
  modifiers = {
    move = "CTRL",
    resize = "META|CTRL",
  },
})

return config
