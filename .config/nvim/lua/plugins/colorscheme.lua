local palette = {
  bg1 = "#16181a",
  bg2 = "#2a2d32",
  bg3 = "#3c4048",
  bg4 = "#444850",
  fg1 = "#ffffff",
  fg2 = "#7b8496",
  red = "#ff6e5e",
  orange = "#ffffff",
  yellow = "#5eff6c",
  green = "#5ea1ff",
  purple = "#ff5ea0",
  cyan = "#bd5eff",
  pink = "#ffbd5e",
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
      yellow = palette.yellow,
      green = palette.green,
      purple = palette.purple,
      cyan = palette.cyan,
      pink = palette.pink,
      bright_red = palette.red,
      bright_green = palette.green,
      bright_yellow = palette.yellow,
      bright_blue = palette.cyan,
      bright_magenta = palette.purple,
      bright_cyan = palette.cyan,
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
        vim.api.nvim_set_hl(0, "MiniIconsYellow", { fg = "#ff6e5e" })
        vim.api.nvim_set_hl(0, "MiniIconsPurple", { fg = palette.cyan })
        vim.api.nvim_set_hl(0, "MiniIconsOrange", { fg = palette.pink })
        vim.api.nvim_set_hl(0, "MiniIconsGreen", { fg = palette.yellow })
        vim.api.nvim_set_hl(0, "MiniIconsAzure", { fg = palette.green })
        vim.api.nvim_set_hl(0, "MiniIconsGrey", { fg = palette.fg2 })
        vim.api.nvim_set_hl(0, "MiniIconsCyan", { fg = palette.green })
        vim.api.nvim_set_hl(0, "MiniIconsBlue", { fg = palette.green })
        vim.api.nvim_set_hl(0, "MiniIconsRed", { fg = palette.red })
      end,
    })

    vim.cmd('colorscheme dracula')
  end,
}
