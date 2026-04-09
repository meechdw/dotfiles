require("supermaven-nvim").setup({
  keymaps = {
    accept_suggestion = "<C-a>",
  },
})

vim.keymap.set("n", "<leader>at", "<cmd>SupermavenToggle<cr>", require("opts"))
