return {
  "olimorris/codecompanion.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/mcphub.nvim",
  },
  keys = {
    { "<leader>cc", "<cmd>CodeCompanionChat<cr>" },
    { "<leader>ca", "<cmd>CodeCompanionActions<cr>" },
  },
  opts = {
    display = {
      chat = {
        window = {
          position = "right",
        },
      },
    },
    strategies = {
      chat = {
        adapter = "anthropic",
      },
      inline = {
        adapter = "anthropic",
      },
    },
    extensions = {
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          make_vars = true,
          make_slash_commands = true,
          show_result_in_chat = true,
        },
      },
    },
  },
}
