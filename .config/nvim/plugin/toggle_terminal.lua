local general_term_bufnr = nil

local function toggle_general_terminal()
  if general_term_bufnr and vim.api.nvim_buf_is_loaded(general_term_bufnr) then
    vim.api.nvim_set_current_buf(general_term_bufnr)
    return
  end

  vim.cmd(":te")
  general_term_bufnr = vim.api.nvim_get_current_buf()
end

local function toggle_specific_terminal(command)
  local term_bufnr = nil
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(bufnr) and vim.api.nvim_buf_get_name(bufnr):match(command) then
      term_bufnr = bufnr
      break
    end
  end

  if term_bufnr then
    vim.api.nvim_set_current_buf(term_bufnr)
  else
    vim.cmd(":te " .. command)
  end
end

local function toggle_terminal(command)
  if command.args == "" then
    toggle_general_terminal()
  else
    toggle_specific_terminal(command.args)
  end
end

vim.api.nvim_create_user_command("ToggleTerminal", toggle_terminal, { nargs = "?" })

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerminal<cr>", opts)
vim.keymap.set("n", "<leader>gg", "<cmd>ToggleTerminal lazygit<cr><cmd>startinsert<cr>", opts)
