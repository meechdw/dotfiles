return {
  "rgroli/other.nvim",
  keys = {
    { "<leader>ot", "<cmd>:Other test<cr>" },
    { "<leader>os", "<cmd>:Other source<cr>" },
    { "<leader>oh", "<cmd>:Other header<cr>" },
  },
  opts = {
    mappings = {
      {
        pattern = "(.+)/src/(.+)%.cpp$",
        target = {
          {
            target = "%1/test/%2_test.cpp",
            context = "test",
          },
          {
            target = "%1/src/%2.h",
            context = "header",
          },
        },
      },
      {
        pattern = "(.+)/src/(.+)%.h$",
        target = {
          {
            target = "%1/src/%2.cpp",
            context = "source",
          },
          {
            target = "%1/test/%2_test.cpp",
            context = "test",
          },
        },
      },
      {
        pattern = "(.+)/test/(.+)_test%.cpp$",
        target = {
          {
            target = "%1/src/%2.cpp",
            context = "source",
          },
          {
            target = "%1/src/%2.h",
            context = "header",
          },
        },
      },
      {
        pattern = "(.+)/(.+)%.go$",
        target = "%1/%2_test.go",
        context = "test",
      },
      {
        pattern = "(.+)/(.+)_test%.go$",
        target = "%1/%2.go",
        context = "source",
      },
      {
        pattern = "(.+)/src/(.+)%.scala$",
        target = "%1/test/src/%2Spec.scala",
        context = "test",
      },
      {
        pattern = "(.+)/test/src/(.+)Spec%.scala$",
        target = "%1/src/%2.scala",
        context = "source",
      },
    },
  },
  config = function(_, opts)
    require("other-nvim").setup(opts)
  end,
}
