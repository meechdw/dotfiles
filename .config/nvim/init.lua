vim.g.mapleader = " "
vim.g.zig_fmt_autosave = false
vim.opt.clipboard = "unnamedplus"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 7
vim.opt.cmdheight = 0

vim.diagnostic.config({
  float = { border = "rounded" },
  signs = false,
})

require("config.lazy")
