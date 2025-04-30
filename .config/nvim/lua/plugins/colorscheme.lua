return {
  "Mofiqul/dracula.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    colors = {
      bg = "#1a1a1a",
      fg = "#d8dee9",
      selection = "#292929",
      comment = "#6d6d6d",
      red = "#ff6464",
      orange = "#83d6c5",
      yellow = "#ebc88e",
      green = "#eeb080",
      purple = "#a99cf5",
      cyan = "#87c3ff",
      pink = "#e394dc",
      bright_red = "#ff6464",
      bright_green = "#eeb080",
      bright_yellow = "#ebc88e",
      bright_blue = "#87c3ff",
      bright_magenta = "#a99cf5",
      bright_cyan = "#87c3ff",
      bright_white = "#d8dee9",
      menu = "#1a1a1a",
      visual = "#303030",
      gutter_fg = "#505050",
      nontext = "#505050",
      white = "#d8dee9",
      black = "#141414",
    },
    overrides = function(colors)
      return {
        CursorLineNr = { bold = false },
        WinSeparator = { fg = colors.gutter_fg },
        AvanteSidebarWinSeparator = { fg = colors.gutter_fg },
        FloatBorder = { fg = colors.comment },
        IblIndent = { fg = "#353535" },
      }
    end,
  },
  config = function(_, opts)
    require("dracula").setup(opts)
    vim.cmd("colorscheme dracula")
    vim.g.terminal_color_4 = "#87c3ff"
    vim.g.terminal_color_7 = "#9a9dab"
  end,
}
