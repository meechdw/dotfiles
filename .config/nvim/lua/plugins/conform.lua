require("conform").setup({
  formatters_by_ft = {
    cmake = { "cmake_format" },
    css = { "prettierd" },
    go = { "goimports", "gofumpt" },
    html = { "prettierd" },
    javascript = { "eslint_d", "prettierd" },
    javascriptreact = { "eslint_d", "prettierd" },
    json = { "prettierd" },
    jsonc = { "prettierd" },
    typescript = { "eslint_d", "prettierd" },
    typescriptreact = { "eslint_d", "prettierd" },
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
