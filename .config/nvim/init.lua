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
vim.opt.laststatus = 3
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:block-TermCursor"

vim.diagnostic.config({
  virtual_text = true,
  signs = false,
  float = {
    border = "rounded",
    max_width = 100,
  },
})

require("config.lazy")
