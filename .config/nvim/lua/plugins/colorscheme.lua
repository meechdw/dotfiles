return {
  "EdenEast/nightfox.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    palettes = {
      carbonfox = {
        bg2 = "#2b2b2b",
        bg3 = "#3b3b3b",
        bg4 = "#5e5e5e",
      },
    },
    groups = {
      carbonfox = {
        CursorLineNr = { fg = "palette.fg1" },
        CursorLine = { bg = "palette.bg2" },
        Comment = { fg = "palette.fg3" },
        FloatBorder = { fg = "palette.bg4" },
        NormalFloat = { bg = "palette.bg1" },
        TelescopeTitle = { fg = "palette.fg3" },
        TelescopePromptCounter = { fg = "palette.fg3" },
        Visual = { bg = "palette.bg3" },
        WinSeparator = { fg = "palette.bg4" },
        BlinkCmpLabelDetail = { fg = "palette.fg2" },
        BlinkCmpScrollBarThumb = { bg = "palette.fg3" },
        BlinkCmpDoc = { bg = "palette.bg1" },
        BlinkCmpDocBorder = { bg = "palette.bg1", fg = "palette.bg4" },
        MiniIndentscopeSymbol = { fg = "palette.bg4" },
        NeoTreeNormal = { bg = "palette.bg1" },
      },
    },
  },
  config = function(_, opts)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "zig",
      callback = function()
        vim.fn.matchadd("ZigReturn", "\\(//.*\\|^test.*\\)\\@<!\\<return\\>", 200)
      end,
    })

    vim.api.nvim_set_hl(0, "ZigReturn", { fg = "#ee5396" })

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
