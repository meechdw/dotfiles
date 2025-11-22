local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.keys = require("keys")

config.font = wezterm.font("BlexMono Nerd Font", { weight = "Medium" })
config.font_size = 16
config.native_macos_fullscreen_mode = true
config.show_new_tab_button_in_tab_bar = false
config.show_close_tab_button_in_tabs = false
config.audible_bell = "Disabled"
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.inactive_pane_hsb = { saturation = 1, brightness = 1 }

local colors = wezterm.color.get_builtin_schemes()["Gruvbox Material (Gogh)"]

colors.brights[1] = "#928374"
colors.split = "#5a524c"
colors.selection_bg = "#45403d"
colors.tab_bar = { inactive_tab_edge = "#333333" }

config.colors = colors

local function tab_title(tab_info)
  local title = tab_info.tab_title
  if title and #title > 0 then
    return title
  end

  return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab)
  return {
    { Text = "  " .. tab.tab_index + 1 .. ": " .. tab_title(tab) .. "  " },
  }
end)

return config
