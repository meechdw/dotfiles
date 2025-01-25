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
    on_highlights = function(hl, c)
      hl.WinSeparator = { fg = c.fg_gutter }
      hl.CursorLineNr = { fg = c.fg }
      hl.LineNrAbove = { fg = c.fg_dark }
      hl.LineNrBelow = { fg = c.fg_dark }
      hl.SignColumn = { fg = c.yellow }
      hl.FzfLuaBackdrop = { bg = c.bg_dark }
    end,
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd("colorscheme tokyonight")
  end,
}
