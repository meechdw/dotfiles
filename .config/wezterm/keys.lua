local scrollback = require("scrollback")
local workspace_switcher = require("workspace_switcher")

local wezterm = require("wezterm")
local action = wezterm.action

return {
  { key = "s", mods = "CMD", action = workspace_switcher.switch_workspace() },
  { key = "a", mods = "CMD", action = workspace_switcher.switch_to_previous_workspace() },
  { key = "f", mods = "CTRL", action = scrollback.send_to_fzf() },
  { key = "e", mods = "CTRL", action = scrollback.send_to_nvim() },
  { key = "f", mods = "CMD|CTRL", action = action.ToggleFullScreen },
  {
    key = "k",
    mods = "CMD",
    action = action.Multiple({
      action.ClearScrollback("ScrollbackAndViewport"),
      action.SendKey({ key = "l", mods = "CTRL" }),
    }),
  },
  { key = "v", mods = "CTRL", action = action.ActivateCopyMode },
  {
    key = "o",
    mods = "CMD",
    action = action.SwitchToWorkspace({
      name = "ollama",
      spawn = {
        args = { "zsh", "-c", "ollama serve" },
        cwd = os.getenv("HOME"),
      },
    }),
  },
  { key = "w", mods = "CMD", action = action.CloseCurrentTab({ confirm = false }) },
  { key = "LeftArrow", mods = "CMD|SHIFT", action = action.MoveTabRelative(-1) },
  { key = "RightArrow", mods = "CMD|SHIFT", action = action.MoveTabRelative(1) },
  { key = "d", mods = "CMD", action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  {
    key = "d",
    mods = "CMD|SHIFT",
    action = action.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  { key = "w", mods = "CMD|SHIFT", action = action.CloseCurrentPane({ confirm = false }) },
  { key = "r", mods = "CMD", action = action.RotatePanes("Clockwise") },
  { key = "z", mods = "CTRL", action = action.TogglePaneZoomState },
  { key = "h", mods = "CMD|SHIFT", action = action.ActivatePaneDirection("Left") },
  { key = "l", mods = "CMD|SHIFT", action = action.ActivatePaneDirection("Right") },
  { key = "j", mods = "CMD|SHIFT", action = action.ActivatePaneDirection("Down") },
  { key = "k", mods = "CMD|SHIFT", action = action.ActivatePaneDirection("Up") },
  { key = "Enter", mods = "OPT", action = action.DisableDefaultAssignment },
  { key = "=", mods = "CTRL", action = action.DisableDefaultAssignment },
  { key = "-", mods = "CTRL", action = action.DisableDefaultAssignment },
}
