require("nvim-treesitter").install({
  "bash",
  "c",
  "cmake",
  "cpp",
  "css",
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
  "templ",
  "tsx",
  "typescript",
  "yaml",
  "zig",
})

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})

vim.keymap.set("n", "<leader>tc", function()
  print(vim.inspect(vim.treesitter.get_captures_at_cursor()))
end, require("opts"))
