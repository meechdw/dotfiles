local palette = {
  bg1 = "#16181a",
  bg2 = "#2a2d32",
  bg3 = "#3c4048",
  bg4 = "#444850",
  fg1 = "#ffffff",
  fg2 = "#7b8496",
  blue = "#5ea1ff",
  cyan = "#5ef1ff",
  green = "#5eff6c",
  orange = "#ffbd5e",
  pink = "#ff5ea0",
  purple = "#bd5eff",
  red = "#ff6e5e",
  yellow = "#ffbd5e",
}

return {
  "Mofiqul/dracula.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    colors = {
      bg = palette.bg1,
      fg = palette.fg1,
      selection = palette.bg2,
      comment = palette.fg2,
      red = palette.red,
      orange = palette.fg1,
      yellow = palette.green,
      green = palette.blue,
      purple = palette.pink,
      cyan = palette.purple,
      pink = palette.orange,
      bright_red = palette.red,
      bright_green = palette.blue,
      bright_yellow = palette.green,
      bright_blue = palette.purple,
      bright_magenta = palette.pink,
      bright_cyan = palette.purple,
      bright_white = palette.fg1,
      menu = palette.bg1,
      visual = palette.bg3,
      gutter_fg = palette.fg2,
      nontext = palette.fg2,
      white = palette.fg1,
      black = palette.bg1,
    },
  },
  config = function(_, opts)
    require("dracula").setup(opts)

    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "dracula",
      callback = function()
        vim.api.nvim_set_hl(0, "CursorLineNr", { bold = false })
        vim.api.nvim_set_hl(0, "WinSeparator", { fg = palette.bg4 })
        vim.api.nvim_set_hl(0, "FloatBorder", { fg = palette.fg2 })
        vim.api.nvim_set_hl(0, "StatusLine", { bg = palette.bg1 })
        vim.api.nvim_set_hl(0, "IblIndent", { fg = palette.bg2 })
        vim.api.nvim_set_hl(0, "MiniIconsYellow", { fg = palette.yellow })
        vim.api.nvim_set_hl(0, "MiniIconsPurple", { fg = palette.purple })
        vim.api.nvim_set_hl(0, "MiniIconsOrange", { fg = palette.orange })
        vim.api.nvim_set_hl(0, "MiniIconsGreen", { fg = palette.green })
        vim.api.nvim_set_hl(0, "MiniIconsAzure", { fg = palette.blue })
        vim.api.nvim_set_hl(0, "MiniIconsGrey", { fg = palette.fg2 })
        vim.api.nvim_set_hl(0, "MiniIconsCyan", { fg = palette.cyan })
        vim.api.nvim_set_hl(0, "MiniIconsBlue", { fg = palette.blue })
        vim.api.nvim_set_hl(0, "MiniIconsRed", { fg = palette.red })

        vim.g.terminal_color_0  = palette.bg1
        vim.g.terminal_color_1  = palette.red
        vim.g.terminal_color_2  = palette.green
        vim.g.terminal_color_3  = palette.yellow
        vim.g.terminal_color_4  = palette.blue
        vim.g.terminal_color_5  = palette.purple
        vim.g.terminal_color_6  = palette.cyan
        vim.g.terminal_color_7  = palette.fg2
        vim.g.terminal_color_8  = palette.bg3
        vim.g.terminal_color_9  = palette.red
        vim.g.terminal_color_10 = palette.green
        vim.g.terminal_color_11 = palette.yellow
        vim.g.terminal_color_12 = palette.blue
        vim.g.terminal_color_13 = palette.purple
        vim.g.terminal_color_14 = palette.cyan
        vim.g.terminal_color_15 = palette.fg1
      end,
    })

    vim.cmd("colorscheme dracula")
  end,
}
