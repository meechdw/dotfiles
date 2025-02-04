return {
  "neanias/everforest-nvim",
  lazy = false,
  priority = 1000,
  opts = {
    background = "hard",
    ui_contrast = "high",
    colours_override = function(palette)
      palette.bg_dim = "#14191b"
      palette.bg0 = "#1b2024"
      palette.bg1 = "#212b2e"
      palette.bg2 = "#273134"
      palette.bg3 = "#2e383c"
      palette.bg4 = "#343c41"
      palette.bg5 = "#384441"
      palette.bg_visual = "#343c41"
      palette.fg = "#d6c7a7"
      palette.red = "#ea7a7c"
      palette.orange = "#ea9671"
      palette.yellow = "#dfbd7b"
      palette.green = "#a8c57b"
      palette.aqua = "#7ec590"
      palette.blue = "#7ac0b7"
      palette.purple = "#da95b6"
      palette.grey0 = "#788775"
      palette.grey1 = "#829588"
      palette.grey2 = "#9bab9f"
      palette.statusline1 = "#a8c57b"
      palette.statusline2 = "#d6c7a7"
      palette.statusline3 = "#ea7a7c"
    end,
    on_highlights = function(hl, palette)
      hl.WinSeparator = { fg = palette.bg5 }
      hl.NormalFloat = { bg = palette.bg0 }
      hl.FloatBorder = { bg = palette.bg0, fg = palette.bg5 }
      hl.FzfLuaBackdrop = { bg = palette.bg0 }
      hl.FzfLuaBorder = { fg = palette.grey0 }
    end,
  },
  config = function(_, opts)
    require("everforest").setup(opts)
    vim.cmd("colorscheme everforest")
  end,
}
