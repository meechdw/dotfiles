-- A map of language server names and their corresponding executables. Because we
-- use Nix flakes, we only want to enable language servers that are available in the
-- environment.
local servers = {
  { "bashls", "bash-language-server" },
  "biome",
  "clangd",
  { "cssls", "vscode-css-language-server" },
  { "docker_language_server", "docker-language-server" },
  { "eslint", "vscode-eslint-language-server" },
  "gopls",
  { "html", "vscode-html-language-server" },
  { "jsonls", "vscode-json-language-server" },
  { "jsonls", "vscode-json-languageserver" },
  { "just", "just-lsp" },
  { "lua_ls", "lua-language-server" },
  { "neocmake", "neocmakelsp" },
  "nixd",
  { "postgres_lsp", "postgres-language-server" },
  { "rust_analyzer", "rust-analyzer" },
  "taplo",
  "templ",
  { "ts_ls", "typescript-language-server" },
  { "yamlls", "yaml-language-server" },
  "zls",
}

vim.filetype.add({
  pattern = {
    ["%.env[%.%w_.-]*"] = "sh",
  },
})

local configs = {
  bashls = {
    filetypes = { "ash", "bash", "env", "sh", "zsh" },
    handlers = {
      ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
        local uri = result.uri
        local fname = vim.uri_to_fname(uri)
        local filename = vim.fn.fnamemodify(fname, ":t")

        if filename:match("^%.env$") or filename:match("^%.env%.") then
          return
        end

        vim.lsp.handlers["textDocument/publishDiagnostics"](err, result, ctx, config)
      end,
    },
  },
  clangd = {
    cmd = { "clangd", "--offset-encoding=utf-16", "--function-arg-placeholders=0" },
  },
  gopls = {
    settings = {
      gopls = {
        staticcheck = true,
        analyses = {
          ST1000 = false,
        },
      },
    },
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
}

local base_config = { capabilities = require("blink.cmp").get_lsp_capabilities() }

for _, server in ipairs(servers) do
  local name, cmd
  if type(server) == "string" then
    name, cmd = server, server
  else
    name, cmd = unpack(server)
  end
  if vim.fn.executable(cmd or name) == 1 then
    vim.lsp.config(name, vim.tbl_deep_extend("keep", base_config, configs[name] or {}))
    vim.lsp.enable(name)
  end
end

local opts = require("opts")

local withMaxWidth = function(fn, max_width)
  return function()
    fn({ max_width = max_width })
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == "zls" then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})

vim.keymap.set("n", "<leader>r", "<cmd>LspRestart<cr>")
vim.keymap.set("n", "<leader>k", withMaxWidth(vim.lsp.buf.hover, 100), opts)
vim.keymap.set("n", "<leader>ld", withMaxWidth(vim.lsp.buf.definition, 100), opts)
vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
