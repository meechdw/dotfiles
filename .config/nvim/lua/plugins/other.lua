return {
  "rgroli/other.nvim",
  keys = {
    { "<leader>ot", "<cmd>:Other test<cr>" },
    { "<leader>oi", "<cmd>:Other implementation<cr>" },
  },
  opts = {
    mappings = {
      {
        pattern = "(.+)/src/(.+)/(.+)%.scala$",
        target = "%1/test/src/%2/%3Spec.scala",
        context = "test",
      },
      {
        pattern = "(.+)/test/src/(.+)/(.+)Spec%.scala$",
        target = "%1/src/%2/%3.scala",
        context = "implementation",
      },
    },
  },
  config = function(_, opts)
    require("other-nvim").setup(opts)
  end,
}
