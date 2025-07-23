return {
  "folke/flash.nvim",
  event = "VeryLazy",
  keys = {
    { "s", mode = { "n", "v", "x", "o" }, "<cmd>lua require('flash').jump()<cr>" },
    { "r", mode = { "o" }, "<cmd>lua require('flash').remote()<cr>" },
    { "L", mode = { "n", "x", "o" }, "<cmd>lua require('flash').treesitter()<cr>" },
  },
  opts = {
    modes = {
      char = { enabled = false },
    },
    prompt = {
      enabled = false,
    },
  },
}
