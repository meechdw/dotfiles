return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      "<leader>ha",
      function()
        require("harpoon"):list():add()
      end,
    },
    {
      "<leader>ho",
      function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list(), {
          border = "rounded",
          title_pos = "center",
        })
      end,
    },
    {
      "<leader>1",
      function()
        require("harpoon"):list():select(1)
      end,
    },
    {
      "<leader>2",
      function()
        require("harpoon"):list():select(2)
      end,
    },
    {
      "<leader>3",
      function()
        require("harpoon"):list():select(3)
      end,
    },
    {
      "<leader>4",
      function()
        require("harpoon"):list():select(4)
      end,
    },
    {
      "<leader>5",
      function()
        require("harpoon"):list():select(5)
      end,
    },
  },
  opts = {},
}
