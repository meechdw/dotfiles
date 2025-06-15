return {
  "supermaven-inc/supermaven-nvim",
  lazy = false,
  keys = {
    { "<leader>at", "<cmd>SupermavenToggle<cr>" },
  },
  opts = {
    keymaps = {
      accept_suggestion = "<Right>",
    },
  },
}
