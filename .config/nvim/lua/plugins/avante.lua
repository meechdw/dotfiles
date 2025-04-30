return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  build = "make BUILD_FROM_SOURCE=true",
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
    "MeanderingProgrammer/render-markdown.nvim",
  },
  opts = {
    behaviour = { auto_suggestions = false },
    hints = { enabled = false },
    mappings = {
      suggestion = { accept = "<M-\\>" },
    },
    windows = {
      sidebar_header = { enabled = false },
    },
    selector = {
      provider = "telescope",
    },
  },
}
