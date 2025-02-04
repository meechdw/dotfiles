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
    files = {
      rg_opts = "--files --hidden --glob '!**/.git/**'",
      git_icons = false,
    },
    grep = {
      rg_opts = "--line-number --column --no-heading --color=always --smart-case --hidden --glob '!**/.git/**'",
      git_icons = false,
    },
  },
}
