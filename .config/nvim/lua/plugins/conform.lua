require("conform").setup({
  formatters_by_ft = {
    cmake = { "cmake_format" },
    go = { "goimports", "gofumpt" },
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
  notify_on_error = false,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    pcall(require("conform").format, { bufnr = args.buf })
  end,
})
