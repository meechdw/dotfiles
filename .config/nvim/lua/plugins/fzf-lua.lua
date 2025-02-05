return {
  "ibhagwan/fzf-lua",
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  keys = {
    { "<leader>ff", "<cmd>FzfLua files<cr>" },
    { "<leader>fg", "<cmd>FzfLua live_grep<cr>" },
    { "<leader>fb", "<cmd>FzfLua buffers<cr>" },
    { "<leader>fr", "<cmd>FzfLua lsp_references<cr>" },
    { "<leader>fd", "<cmd>FzfLua diagnostics_document<cr>" },
    { "<leader>fw", "<cmd>FzfLua diagnostics_workspace<cr>" },
  },
  opts = {
    "telescope",
    git_icons = false,
    files = {
      rg_opts = "--files --hidden --glob '!**/.git/**'",
      winopts = { preview = { hidden = true } },
    },
    buffers = {
      winopts = { preview = { hidden = true } },
    },
    grep = {
      rg_opts = "--line-number --column --no-heading --color=always --smart-case --hidden --glob '!**/.git/**'",
    },
  },
}
