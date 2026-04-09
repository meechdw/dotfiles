require("catppuccin").setup({
  flavour = "macchiato",
  float = { transparent = true },
  no_italic = true,
  no_bold = true,
  no_underline = true,
  custom_highlights = function(colors)
    return {
      WinSeparator = { fg = colors.overlay0 },
      VertSplit = { fg = colors.overlay0 },
      BlinkCmpMenuBorder = { link = "FloatBorder" },
      BlinkCmpMenu = { link = "Normal" },
    }
  end,
})

vim.cmd("colorscheme catppuccin-macchiato")
