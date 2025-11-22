require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "bash",
    "c",
    "cmake",
    "cpp",
    "dockerfile",
    "go",
    "html",
    "javascript",
    "jsdoc",
    "json",
    "lua",
    "make",
    "markdown",
    "nix",
    "rust",
    "sql",
    "svelte",
    "scala",
    "typescript",
    "yaml",
    "zig",
  },
  highlight = { enable = true },
})

vim.keymap.set("n", "<leader>tc", function()
  print(vim.inspect(vim.treesitter.get_captures_at_cursor()))
end, require("opts"))
