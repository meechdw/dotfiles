return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      cmake = { "cmake_format" },
      javascript = { "prettierd" },
      json = { "prettierd" },
      typescript = { "prettierd" },
      lua = { "stylua" },
      markdown = { "prettierd" },
      nix = { "nixfmt" },
      yaml = { "prettierd" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
    formatters = {
      prettierd = { require_cwd = true },
    },
  },
}
