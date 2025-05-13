return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "echasnovski/mini.icons",
  },
  opts = {
    file_types = { "markdown", "codecompanion" },
    completions = { blink = { enabled = true } },
    latex = { enabled = false },
    sign = { enabled = false },
  },
}
