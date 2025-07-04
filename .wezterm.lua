local wezterm = require("wezterm")
local action = wezterm.action
local plugin = wezterm.plugin

local config = wezterm.config_builder()

local workspace_switcher =
  plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")

workspace_switcher.apply_to_config(config)

config.font = wezterm.font("BlexMono Nerd Font", { weight = "Medium" })
config.font_size = 16
config.native_macos_fullscreen_mode = true
config.show_new_tab_button_in_tab_bar = false
config.show_close_tab_button_in_tabs = false
config.audible_bell = "Disabled"
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.color_scheme = "tokyonight"

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
    key = "y",
    mods = "CMD",
    action = action.ActivateCopyMode,
  },
  {
    key = "z",
    mods = "CTRL",
    action = action.TogglePaneZoomState,
  },
  {
    key = "l",
    mods = "CMD",
    action = workspace_switcher.switch_workspace(),
  },
  {
    key = "L",
    mods = "CMD",
    action = workspace_switcher.switch_to_prev_workspace(),
  },
  {
    key = "Enter",
    mods = "OPT",
    action = action.DisableDefaultAssignment,
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
