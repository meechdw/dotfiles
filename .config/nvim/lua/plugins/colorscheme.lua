return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    style = "night",
    styles = {
      comments = { italic = false },
      keywords = { italic = false },
    },
    on_colors = function(colors)
      colors.bg = "#14151f"
      colors.bg_dark = "#14151f"
      colors.bg_highlight = "#232639"
      colors.comment = "#828ab0"
      colors.fg_gutter = "#30374f"
    end,
    on_highlights = function(hl, colors)
      hl.CursorLineNr = { fg = colors.fg }
      hl.WinSeparator = { fg = colors.dark3 }
      hl.FloatBorder = { fg = colors.dark3 }
      hl.LineNrAbove = { fg = "#56628a" }
      hl.LineNrBelow = { fg = "#56628a" }
      hl.MiniIndentscopeSymbol = { fg = "#52597a" }
      hl.BlinkCmpMenu = { bg = "#101119" }
      hl.BlinkCmpLabel = { bg = "#101119" }
      hl.BlinkCmpLabelDetail = { fg = colors.dark5 }
      hl.BlinkCmpLabelDescription = { fg = colors.fg_dark }
      hl.BlinkCmpDocBorder = { fg = colors.dark3 }
      hl.BlinkCmpDocSeparator = { fg = colors.dark3 }
      hl.FlashCurrent = { bg = colors.blue0, fg = colors.fg }
      hl.TelescopeNormal = { bg = colors.bg }
      hl.TelescopeResults = { bg = colors.bg }
      hl.TelescopePreview = { bg = colors.bg }
      hl.TelescopePrompt = { bg = colors.bg }
      hl.TelescopePromptCounter = { fg = colors.comment }
      hl.TelescopePromptPrefix = { fg = colors.orange }
      hl.TelescopeSelection = { bg = colors.bg_highlight }
      hl.RenderMarkdownCode = { bg = colors.bg_highlight }
      hl.RenderMarkdownCodeInline = { bg = colors.bg_highlight }
    end,
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd("colorscheme tokyonight")
  end,
}
