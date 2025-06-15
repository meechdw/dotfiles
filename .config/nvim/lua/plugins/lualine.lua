return {
  "nvim-lualine/lualine.nvim",
  config = function()
    local function get_lsp_status()
      local bufnr = vim.api.nvim_get_current_buf()
      local clients = vim.lsp.get_clients({ bufnr = bufnr })

      if #clients > 0 then
        return clients[1].name
      end

      return ""
    end

    local theme = require("lualine.themes.tokyonight")
    local bg = "#212436"
    local fg = "#a9b1d6"

    theme.normal.a.fg = fg
    theme.normal.a.bg = bg
    theme.normal.c.fg = fg
    theme.normal.c.bg = bg

    theme.command.a.fg = fg
    theme.command.a.bg = bg

    theme.inactive.a.fg = fg
    theme.inactive.a.bg = bg
    theme.inactive.c.fg = fg
    theme.inactive.c.bg = bg

    theme.insert.a.fg = fg
    theme.insert.a.bg = bg

    theme.replace.a.fg = fg
    theme.replace.a.bg = bg

    theme.terminal.a.fg = fg
    theme.terminal.a.bg = bg

    theme.visual.a.fg = fg
    theme.visual.a.bg = bg

    require("lualine").setup({
      options = {
        theme = theme,
        component_separators = "",
        section_separators = "",
      },
      sections = {
        lualine_a = {
          { "mode", color = { gui = "bold" } },
        },
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
