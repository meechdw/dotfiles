local opencode = require("opencode")
local opts = require("opts")

vim.keymap.set({ "n", "x" }, "<leader>aa", function()
  opencode.ask("@this: ", { submit = true })
end, opts)

vim.keymap.set({ "n", "x" }, "<leader>ai", function()
  opencode.select()
end, opts)

vim.keymap.set({ "n", "x" }, "<leader>ap", function()
  opencode.prompt("@this")
end, opts)
