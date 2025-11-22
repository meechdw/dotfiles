require("flash").setup({
  modes = {
    char = { enabled = false },
  },
  prompt = {
    enabled = false,
  },
})

local opts = require("opts")

vim.keymap.set({ "n", "v", "x", "o" }, "s", "<cmd>lua require('flash').jump()<cr>", opts)
vim.keymap.set("o", "r", "<cmd>lua require('flash').remote()<cr>", opts)
vim.keymap.set({ "n", "v", "x", "o" }, "L", "<cmd>lua require('flash').treesitter()<cr>", opts)
