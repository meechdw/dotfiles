return {
  "catppuccin/nvim",
  lazy = false,
  priority = 1000,
  opts = {
    flavour = "macchiato",
    no_italic = true,
    no_bold = true,
    no_underline = true,
    float = {
      transparent = true,
      solid = true,
    },
    custom_highlights = function(colors)
      return {
        LineNr = { fg = colors.surface2 },
        WinSeparator = { link = "FloatBorder" },
        NeoTreeWinSeparator = { link = "WinSeparator" },
        BlinkCmpMenu = { link = "Normal" },
        BlinkCmpMenuBorder = { link = "FloatBorder" },
        BlinkCmpSignatureHelpBorder = { link = "FloatBorder" },
        BlinkCmpDocBorder = { link = "FloatBorder" },
        BlinkCmpDocSeparator = { link = "FloatBorder" },
        BlinkCmpLabel = { link = "Normal" },
        BlinkCmpLabelDetail = { link = "Comment" },
        BlinkCmpLabelDescription = { link = "Comment" },
      }
    end,
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd("colorscheme catppuccin")

    -- When NeoTree is opened, the highlight groups get overriden. This is a workaround.
    vim.api.nvim_create_autocmd("BufWinEnter", {
      pattern = "*",
      callback = function()
        if vim.bo.filetype == "neo-tree" then
          vim.api.nvim_set_hl(0, "NeoTreeNormal", { link = "Normal" })
          vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { link = "Normal" })
          vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { link = "Normal" })
        end
      end,
    })
  end,
}
