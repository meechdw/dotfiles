return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "bash",
      "c",
      "cmake",
      "cpp",
      "dockerfile",
      "go",
      "html",
      "javascript",
      "jsdoc",
      "json",
      "lua",
      "make",
      "markdown",
      "nix",
      "rust",
      "sql",
      "svelte",
      "scala",
      "typescript",
      "yaml",
      "zig",
    },
    highlight = { enable = true },
  },
  config = function(_, opts)
    local configs = require("nvim-treesitter.configs")
    configs.setup(opts)
  end,
}
