return {
  dir = "~/src/aider.nvim",
  dev = true,
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "j-hui/fidget.nvim",
  },
  keys = {
    { "<leader>ao", "<cmd>Aider open<cr>", mode = { "n", "v" } },
    { "<leader>aa", "<cmd>Aider add<cr>" },
    { "<leader>ar", "<cmd>Aider remove<cr>" },
    { "<leader>af", "<cmd>Aider quick_fix<cr>", mode = { "v" } },
    { "<leader>au", "<cmd>Aider undo<cr>" },
  },
  opts = {},
}
