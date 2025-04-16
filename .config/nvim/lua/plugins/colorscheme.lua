return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    styles = {
      comments = { italic = false },
      keywords = { italic = false },
      sidebars = "transparent",
      floats = "transparent",
    },
    on_highlights = function(highlights, colors)
      highlights.LineNrAbove = { fg = colors.comment }
      highlights.LineNrBelow = { fg = colors.comment }
      highlights.CursorLineNr = { fg = colors.fg }
      highlights.WinSeparator = { fg = colors.fg_gutter }
      highlights.AvanteSidebarWinSeparator = { fg = colors.fg_gutter }
      highlights.BlinkCmpMenu = { bg = colors.bg_dark }
    end,
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd("colorscheme tokyonight")
  end,
}
