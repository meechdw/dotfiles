vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_disable_italic = 1
vim.g.gruvbox_material_float_style = "blend"
vim.g.gruvbox_material_diagnostic_virtual_text = "colored"

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "SnacksPickerBoxCursorLine", { link = "Visual" })
    vim.api.nvim_set_hl(0, "SnacksPickerListCursorLine", { link = "Visual" })
    vim.api.nvim_set_hl(0, "SnacksPickerPathHidden", { link = "Comment" })
    vim.api.nvim_set_hl(0, "FylerIndentMarker", { link = "WinSeparator" })
    vim.api.nvim_set_hl(0, "BlinkCmpMenu", { link = "Normal" })
    vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { link = "Visual" })
    vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { link = "FloatBorder" })
    vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { link = "FloatBorder" })
    vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { link = "FloatBorder" })
    vim.api.nvim_set_hl(0, "BlinkCmpDocSeparator", { link = "FloatBorder" })
    vim.api.nvim_set_hl(0, "BlinkCmpLabelDetail", { link = "Comment" })
    vim.api.nvim_set_hl(0, "BlinkCmpLabelDescription", { link = "Comment" })

    for _, hl in ipairs(vim.fn.getcompletion("", "highlight")) do
      local details = vim.api.nvim_get_hl(0, { name = hl })
      if details.italic then
        details.italic = nil
        ---@diagnostic disable-next-line -- the type checker doesn't like this, but it's fine
        vim.api.nvim_set_hl(0, hl, details)
      end
    end
  end,
})

vim.cmd("colorscheme gruvbox-material")
