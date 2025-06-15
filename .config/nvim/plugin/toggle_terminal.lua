local buffers = {}

local function toggle_terminal(cmd)
  cmd = cmd or ""

  if buffers[cmd] and vim.api.nvim_buf_is_loaded(buffers[cmd]) then
    vim.api.nvim_set_current_buf(buffers[cmd])
    vim.cmd(":startinsert")
    return
  end

  if cmd ~= "" then
    vim.cmd(string.format(":te %s", cmd))
  else
    vim.cmd(":te")
  end

  local bufnr = vim.api.nvim_get_current_buf()
  vim.cmd(":startinsert")
  buffers[cmd] = bufnr
end

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>tt", toggle_terminal, opts)

vim.keymap.set("n", "<leader>gg", function()
  toggle_terminal("lazygit")
end, opts)
