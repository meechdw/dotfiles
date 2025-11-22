-- A map of language server names and their corresponding executables. Because we
-- use Nix flakes, we only want to enable language servers that are available in the
-- environment.
local servers = {
  { "bashls", "bash-language-server" },
  { "docker_compose_language_service", "docker-compose-langserver" },
  { "dockerls", "docker-langserver" },
  "gopls",
  { "html", "vscode-html-language-server" },
  { "jsonls", "vscode-json-languageserver" },
  { "lua_ls", "lua-language-server" },
  { "neocmake", "neocmakelsp" },
  "nixd",
  { "rust_analyzer", "rust-analyzer" },
  "taplo",
  { "ts_ls", "typescript-language-server" },
  { "yamlls", "yaml-language-server" },
  "zls",
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

vim.keymap.set("n", "<leader>r", "<cmd>LspRestart<cr>")
vim.keymap.set("n", "<leader>k", withMaxWidth(vim.lsp.buf.hover, 100), opts)
vim.keymap.set("n", "<leader>ld", withMaxWidth(vim.lsp.buf.definition, 100), opts)
vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
