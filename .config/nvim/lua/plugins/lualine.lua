return {
  "nvim-lualine/lualine.nvim",
  config = function()
    local function get_lsp_status()
      local bufnr = vim.api.nvim_get_current_buf()
      local clients = vim.lsp.get_clients(bufnr)
      local filtered_clients = vim.tbl_filter(function(client)
        return client.name ~= "GitHub Copilot"
      end, clients)

      if #filtered_clients > 0 then
        return filtered_clients[1].name
      else
        return ""
      end
    end

    local theme = require("lualine.themes.tokyonight")
    local bg = theme.normal.c.bg

    theme.normal.a.fg = theme.normal.a.bg
    theme.normal.a.bg = bg
    theme.command.a.fg = theme.command.a.bg
    theme.command.a.bg = bg
    theme.inactive.a.fg = theme.inactive.a.bg
    theme.inactive.a.bg = bg
    theme.insert.a.fg = theme.insert.a.bg
    theme.insert.a.bg = bg
    theme.replace.a.fg = theme.replace.a.bg
    theme.replace.a.bg = bg
    theme.visual.a.fg = theme.visual.a.bg
    theme.visual.a.bg = bg
    theme.terminal.a.fg = theme.terminal.a.bg
    theme.terminal.a.bg = bg

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
        lualine_x = { get_lsp_status, "location" },
        lualine_y = {},
        lualine_z = {},
      },
    })
  end,
}
