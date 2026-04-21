local function get_lsp_status()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })

  return table.concat(
    vim.tbl_map(function(client)
      return client.name
    end, clients),
    " "
  )
end

require("lualine").setup({
  options = {
    theme = "everforest",
    component_separators = "",
    section_separators = "",
  },
  sections = {
    lualine_b = { "branch" },
    lualine_c = { { "filename", path = 1 } },
    lualine_x = { "diagnostics", get_lsp_status, "encoding" },
    lualine_y = { "filetype" },
    lualine_z = { "location" },
  },
})
