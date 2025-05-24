return {
  "EdenEast/nightfox.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    palettes = {
      carbonfox = {
        bg2 = "#2b2b2b",
        bg4 = "#595959",
      },
    },
    groups = {
      carbonfox = {
        CursorLineNr = { fg = "palette.fg1" },
        CursorLine = { bg = "palette.bg2" },
        FloatBorder = { fg = "palette.bg4" },
        NormalFloat = { bg = "palette.bg1" },
        TelescopeTitle = { fg = "palette.blue.base" },
        Visual = { bg = "palette.bg3" },
        WinSeparator = { fg = "palette.bg4" },
        BlinkCmpLabelDetail = { fg = "palette.fg2" },
        BlinkCmpScrollBarThumb = { bg = "palette.fg3" },
        BlinkCmpDoc = { bg = "palette.bg1" },
        BlinkCmpDocBorder = { bg = "palette.bg1", fg = "palette.bg4" },
      },
    },
  },
  config = function(_, opts)
    require("nightfox").setup(opts)
    vim.cmd.colorscheme("carbonfox")

    for _, group in ipairs(vim.fn.getcompletion("", "highlight")) do
      local current = vim.api.nvim_get_hl(0, { name = group })
      current.bold = false
      current.italic = false
      vim.api.nvim_set_hl(0, group, current)
    end

    vim.api.nvim_set_hl(0, "CursorLineNr", { bold = true })
  end,
}
