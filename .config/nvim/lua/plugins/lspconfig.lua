return {
  "neovim/nvim-lspconfig",
  commit = "fb733ac734249ccf293e5c8018981d4d8f59fa8f",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "saghen/blink.cmp" },
  config = function()
    local lspconfig = require("lspconfig")

    local base_config = {
      capabilities = require("blink.cmp").get_lsp_capabilities(),
      handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
          border = "rounded",
          max_width = 100,
        }),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
          border = "rounded",
          max_width = 100,
        }),
      },
    }

    local configs = {
      bashls = {
        filetypes = { "ash", "bash", "env", "sh", "zsh" },
      },
      clangd = {
        cmd = { "clangd", "--offset-encoding=utf-16", "--function-arg-placeholders=0" },
      },
      rust_analyzer = {
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = true,
            completion = {
              callable = {
                snippets = "none",
              },
            },
          },
        },
      },
      jsonls = {
        cmd = { "vscode-json-languageserver", "--stdio" },
      },
    }

    local servers = {
      { "bashls", "bash-language-server" },
      { "docker_compose_language_service", "docker-compose-langserver" },
      { "dockerls", "docker-langserver" },
      { "gopls" },
      { "html", "vscode-html-language-server" },
      { "jsonls", "vscode-json-languageserver" },
      { "lua_ls", "lua-language-server" },
      { "neocmake", "neocmakelsp" },
      { "nixd" },
      { "rust_analyzer", "rust-analyzer" },
      { "taplo" },
      { "ts_ls", "typescript-language-server" },
      { "yamlls", "yaml-language-server" },
      { "zls" },
    }

    for _, server in ipairs(servers) do
      local name, cmd = unpack(server)
      if vim.fn.executable(cmd or name) == 1 then
        lspconfig[name].setup(vim.tbl_deep_extend("keep", base_config, configs[name] or {}))
      end
    end

    vim.diagnostic.config({
      virtual_text = true,
      signs = false,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        border = "rounded",
        max_width = 100,
        source = "always",
        header = "",
        prefix = "",
      },
    })
  end,
}
