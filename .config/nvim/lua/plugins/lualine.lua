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
    component_separators = "",
    section_separators = "",
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      { "mode", color = { gui = "bold" } },
      "branch",
      { "filename", path = 1 },
    },
    lualine_x = { "searchcount", get_lsp_status, "location" },
    lualine_y = {},
    lualine_z = {},
  },
})
