vim.opt_local.wrap = true
vim.opt_local.linebreak = true

if vim.bo.buftype == "" then
  vim.schedule(require("render-markdown").buf_disable)
end
