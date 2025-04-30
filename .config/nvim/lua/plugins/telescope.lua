return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
    },
  },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>" },
    { "<leader>fr", "<cmd>Telescope lsp_references<cr>" },
    { "<leader>fd", "<cmd>Telescope diagnostics bufnr=0<cr>" },
    {
      "<leader>fm",
      function()
        require("telescope").extensions.metals.commands()
      end,
    },
    {
      "<leader>fw",
      function()
        require("telescope.extensions").metals.commands()
      end,
    },
  },
  opts = {
    extensions = { fzf = {} },
    pickers = {
      find_files = {
        previewer = false,
        find_command = {
          "rg",
          "--files",
          "--hidden",
          "-g",
          "!**/.git/*",
        },
      },
      buffers = {
        hidden = true,
      },
      live_grep = {
        additional_args = { "--hidden", "--glob", "!**/.git/*" },
      },
    },
  },
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    telescope.load_extension("fzf")
  end,
}
