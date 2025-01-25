return {
  "folke/flash.nvim",
  event = "VeryLazy",
  keys = {
    { "s", "<cmd>lua require('flash').jump()<cr>" },
  },
  opts = {
    modes = {
      char = { enabled = false },
    },
  },
}
