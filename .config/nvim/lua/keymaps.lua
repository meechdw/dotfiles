local opts = require("opts")

vim.keymap.set("n", "<leader>j", "<C-^>", opts)
vim.keymap.set("v", "<leader>p", '"_dP', opts)
vim.keymap.set({ "n", "v" }, "<leader>/", "<cmd>noh<cr>", opts)
vim.keymap.set("t", "<C-ESC>", "<C-\\><C-n>", opts)

vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

vim.keymap.set({ "n", "v" }, "J", "<C-d>zz", opts)
vim.keymap.set({ "n", "v" }, "K", "<C-u>zz", opts)

vim.keymap.set("n", "<leader>tn", "<cmd>tab new<cr>", opts)
vim.keymap.set("n", "<leader>ts", "<cmd>tab split<cr>", opts)
vim.keymap.set("n", "<leader>tw", "<cmd>tabclose<cr>", opts)

vim.keymap.set("n", "<leader>s", "<cmd>vsplit<cr><C-w>l", opts)

local jump = function(count)
  return function()
    vim.diagnostic.jump({ count = count })
  end
end

vim.keymap.set("n", "dn", jump(1), opts)
vim.keymap.set("n", "dp", jump(-1), opts)
vim.keymap.set("n", "do", vim.diagnostic.open_float, opts)

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
