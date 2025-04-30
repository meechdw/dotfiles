return {
  "LunarVim/lunar.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "lunar",
      callback = function()
        vim.api.nvim_set_hl(0, "Visual", { bg = "#31374e" })
        vim.api.nvim_set_hl(0, "Comment", { fg = "#6874a1", italic = true })
        vim.api.nvim_set_hl(0, "LineNr", { fg = "#5e6a97" })
        vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#8e97b8" })
        vim.api.nvim_set_hl(0, "IblIndent", { fg = "#323952" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1a1b26" })
        vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#1a1b26", fg = "#3d59a1" })
        vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "#1a1b26" })
        vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { bg = "#31374e", fg = "#f7768e" })
        vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = "#31374e" })
        vim.api.nvim_set_hl(0, "BlinkCmpLabelDetail", { fg = "#8e97b8" })
        vim.api.nvim_set_hl(0, "BlinkCmpLabelDescription", { fg = "#8e97b8" })
        vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { bg = "#1a1b26", fg = "#3d59a1" })
        vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#5e6a97" })
        vim.api.nvim_set_hl(0, "AvanteSidebarWinSeparator", { fg = "#5e6a97" })
        vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#1a1b26", bg = "#e0af67", bold = true }) -- the last character
        vim.api.nvim_set_hl(0, "FlashCurrent", { fg = "#1a1b26", bg = "#c0caf5" })
        vim.api.nvim_set_hl(0, "FlashMatch", { fg = "#1a1b26", bg = "#c0caf5" })
      end,
    })

    vim.cmd("colorscheme lunar")
  end,
}
