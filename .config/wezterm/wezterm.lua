local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.keys = require("keys")

config.font = wezterm.font("GeistMono Nerd Font", { weight = "Medium" })
config.font_size = 16
config.native_macos_fullscreen_mode = true
config.show_new_tab_button_in_tab_bar = false
config.show_close_tab_button_in_tabs = false
config.audible_bell = "Disabled"
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.inactive_pane_hsb = { saturation = 1, brightness = 1 }

local scheme = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
scheme.ansi[1] = "#9399b2"
scheme.ansi[6] = "#cba6f7"
scheme.brights[1] = "#9399b2"

config.colors = scheme
config.colors.split = "#585b70"

config.colors.tab_bar = {
  inactive_tab_edge = "#333333",
}

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
