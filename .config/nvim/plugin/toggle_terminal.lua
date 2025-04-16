local bufnr = nil

local function toggle_terminal()
  if bufnr and vim.api.nvim_buf_is_loaded(bufnr) then
    vim.api.nvim_set_current_buf(bufnr)
    return
  end

  vim.cmd(":te")
  vim.cmd(":startinsert")

  bufnr = vim.api.nvim_get_current_buf()
end

vim.api.nvim_create_user_command("ToggleTerminal", toggle_terminal, {})

vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerminal<cr>", { noremap = true, silent = true })
