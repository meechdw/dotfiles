require("fyler").setup({
  views = {
    finder = {
      close_on_select = false,
      git_status = {
        enabled = false,
      },
      win = {
        kinds = {
          split_left_most = {
            width = "25%",
          },
        },
      },
    },
  },
})

vim.keymap.set("n", "<leader>n", function()
  require("fyler").toggle({ kind = "split_left_most" })
end, require("opts"))
