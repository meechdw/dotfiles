return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "echasnovski/mini.icons",
  },
  opts = {
    file_types = { "markdown" },
    completions = { blink = { enabled = true } },
    latex = { enabled = false },
    ignore = function(bufnr)
      return vim.api.nvim_buf_get_name(bufnr) ~= ""
    end,
  },
}
