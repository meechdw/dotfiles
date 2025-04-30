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

    local theme = require("lualine.themes.dracula")
    local bg = "#292929"
    local fg = "#999999"

    theme.normal.a.fg = fg
    theme.normal.c.fg = fg
    theme.normal.a.bg = bg
    theme.normal.c.bg = bg
    theme.command.a.fg = fg
    theme.command.c.fg = fg
    theme.command.a.bg = bg
    theme.command.c.bg = bg
    theme.inactive.a.fg = fg
    theme.inactive.c.fg = fg
    theme.inactive.a.bg = bg
    theme.inactive.c.bg = bg
    theme.insert.a.fg = fg
    theme.insert.c.fg = fg
    theme.insert.a.bg = bg
    theme.insert.c.bg = bg
    theme.replace.a.fg = fg
    theme.replace.c.fg = fg
    theme.replace.a.bg = bg
    theme.replace.c.bg = bg
    theme.visual.a.fg = fg
    theme.visual.c.fg = fg
    theme.visual.a.bg = bg
    theme.visual.c.bg = bg

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
        lualine_x = { "diagnostics", "searchcount", get_lsp_status, "location" },
        lualine_y = {},
        lualine_z = {},
      },
    })
  end,
}
