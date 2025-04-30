return {
  "nvim-lualine/lualine.nvim",
  config = function()
    local function get_lsp_status()
      local bufnr = vim.api.nvim_get_current_buf()
      local clients = vim.lsp.get_clients({ bufnr = bufnr })

      local filtered_clients = vim.tbl_filter(function(client)
        return client.name ~= "GitHub Copilot"
      end, clients)

      if #filtered_clients > 0 then
        return filtered_clients[1].name
      else
        return ""
      end
    end

    local theme = require("lualine.themes.lunar")
    local bg = "#292E42"
    local fg = theme.normal.c.fg

    theme.normal.a.fg = fg
    theme.normal.a.bg = bg
    theme.normal.c.fg = fg
    theme.normal.c.bg = bg
    theme.command.a.fg = fg
    theme.command.a.bg = bg
    theme.insert.a.fg = fg
    theme.insert.a.bg = bg
    theme.replace.a.fg = fg
    theme.replace.a.bg = bg
    theme.visual.a.fg = fg
    theme.visual.a.bg = bg

    require("lualine").setup({
      options = {
        theme = theme,
        component_separators = "",
        section_separators = "",
      },
      sections = {
        lualine_b = {},
        lualine_c = {
          { "filename", path = 1 },
        },
        lualine_x = { "searchcount", get_lsp_status, "location" },
        lualine_y = {},
        lualine_z = {},
      },
    })
  end,
}
