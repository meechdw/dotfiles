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
        vim.api.nvim_set_hl(0, "IblIndent", { fg = "#2f354c" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1a1b26" })
        vim.api.nvim_set_hl(0, "FloatTitle", { fg = "#f19660" })
        vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#1a1b26", fg = "#3d59a1" })
        vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "#1a1b26" })
        vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { bg = "#31374e", fg = "#f7768e" })
        vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = "#31374e" })
        vim.api.nvim_set_hl(0, "BlinkCmpLabelDetail", { fg = "#8e97b8" })
        vim.api.nvim_set_hl(0, "BlinkCmpLabelDescription", { fg = "#8e97b8" })
        vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { bg = "#1a1b26", fg = "#3d59a1" })
        vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#5e6a97" })
        vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#1a1b26", bg = "#e0af67", bold = true })
        vim.api.nvim_set_hl(0, "FlashCurrent", { fg = "#1a1b26", bg = "#c0caf5" })
        vim.api.nvim_set_hl(0, "FlashMatch", { fg = "#1a1b26", bg = "#c0caf5" })
        vim.api.nvim_set_hl(0, "TabLineFill", { bg = "#16161e" })
        vim.api.nvim_set_hl(0, "SignColumn", { fg = "#f7768e" })
        vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = "#252b3c" })
        vim.api.nvim_set_hl(0, "Added", { fg = "#5e6a97" })
        vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#2f4516" })
        vim.api.nvim_set_hl(0, "Removed", { fg = "#5e6a97" })
        vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#5f0717" })
        vim.api.nvim_set_hl(0, "Changed", { fg = "#5e6a97" })
        vim.api.nvim_set_hl(0, "DiffText", { bg = "#0b424b" })
        vim.api.nvim_set_hl(0, "MiniDiffOverContext", { bg = "#31374e" })
      end,
    })

    vim.cmd("colorscheme lunar")
  end,
}
