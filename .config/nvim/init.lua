vim.g.mapleader = " "
vim.g.zig_fmt_autosave = false
vim.opt.winborder = "rounded"
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

vim.o.guifont = "GeistMono Nerd Font:h16"
vim.opt.linespace = 2
vim.g.neovide_padding_top = 0
vim.g.neovide_padding_bottom = 0
vim.g.neovide_padding_right = 0
vim.g.neovide_padding_left = 0
vim.g.neovide_show_border = false
vim.g.neovide_cursor_animation_length = 0
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_floating_shadow = false

require("config.lazy")
