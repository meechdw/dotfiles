local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>j", "<C-^>", opts)
vim.keymap.set("v", "<leader>p", '"_dP', opts)
vim.keymap.set("n", "<leader>/", "<cmd>noh<cr>", opts)
vim.keymap.set("t", "<C-ESC>", "<C-\\><C-n>", opts)

vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

vim.keymap.set({ "n", "v" }, "J", "<C-d>zz", opts)
vim.keymap.set({ "n", "v" }, "K", "<C-u>zz", opts)

vim.keymap.set("n", "<leader>tn", "<cmd>tab new<cr>", opts)
vim.keymap.set("n", "<leader>ts", "<cmd>tab split<cr>", opts)
vim.keymap.set("n", "<leader>tw", "<cmd>tabclose<cr>", opts)

vim.keymap.set("n", "<leader>s", "<cmd>vsplit<cr><C-w>l", opts)
vim.keymap.set("n", "<C-q>", "<C-w>q", opts)
vim.keymap.set("n", "<C-=>", "<C-w>=", opts)

vim.keymap.set("n", "<leader>r", "<cmd>LspRestart<cr>")
vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, opts)
vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, opts)
vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)

vim.keymap.set("n", "dn", vim.diagnostic.goto_next)
vim.keymap.set("n", "dp", vim.diagnostic.goto_next)

vim.keymap.set("n", "do", function()
  vim.diagnostic.open_float()
  vim.diagnostic.open_float()
end, opts)

vim.keymap.set("n", "<leader>w", function()
  if vim.api.nvim_win_get_config(0).relative ~= "" then
    vim.api.nvim_win_close(0, true)
    return
  end

  if vim.bo.buftype == "terminal" then
    vim.cmd("bd!")
    return
  end

  vim.api.nvim_command("bp|sp|bn|bd")
end, opts)

vim.keymap.set("n", "<leader>h", function()
  local enabled = not vim.lsp.inlay_hint.is_enabled({})
  vim.lsp.inlay_hint.enable(enabled)
end, opts)
