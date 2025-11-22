require("supermaven-nvim").setup({
  keymaps = {
    accept_suggestion = "<Right>",
  },
})

vim.keymap.set("n", "<leader>at", "<cmd>SupermavenToggle<cr>", require("opts"))
