return {
  "github/copilot.vim",
  config = function()
    local opts = { noremap = true, silent = true }

    vim.keymap.set("n", "<leader>cd", "<cmd>Copilot disable<cr>", opts)
    vim.keymap.set("n", "<leader>ce", "<cmd>Copilot enable<cr>", opts)

    vim.keymap.set("i", "<Right>", 'copilot#Accept("\\<CR>")', {
      expr = true,
      replace_keycodes = false,
    })

    vim.g.copilot_no_tab_map = true
  end,
}
