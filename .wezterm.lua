local wezterm = require("wezterm")
local action = wezterm.action
local plugin = wezterm.plugin

local config = wezterm.config_builder()
local tab_zoom_states = {}

config.font = wezterm.font("GeistMono Nerd Font")
config.font_size = 17
config.native_macos_fullscreen_mode = true
config.show_new_tab_button_in_tab_bar = false
config.show_close_tab_button_in_tabs = false
config.audible_bell = "Disabled"
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.color_scheme = "cyberdream"

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
  { key = "LeftArrow",  mods = "CMD|SHIFT", action = action.MoveTabRelative(-1) },
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
    key = "e",
    mods = "CMD",
    action = wezterm.action_callback(function(window, pane)
      local tab = window:active_tab()
      local tab_id = tab:tab_id()

      if tab_zoom_states[tab_id] then
        tab_zoom_states[tab_id] = false
        window:perform_action(wezterm.action.SetPaneZoomState(false), pane)
        window:perform_action(wezterm.action.ActivatePaneDirection("Down"), pane)
      else
        tab_zoom_states[tab_id] = true
        window:perform_action(wezterm.action.ActivatePaneDirection("Up"), pane)
        window:perform_action(wezterm.action.SetPaneZoomState(true), pane)
      end
    end),
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
