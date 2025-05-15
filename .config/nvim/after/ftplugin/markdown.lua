if vim.bo.buftype == "" then
  require("render-markdown").disable()
end

vim.opt_local.wrap = true
vim.opt_local.linebreak = true
