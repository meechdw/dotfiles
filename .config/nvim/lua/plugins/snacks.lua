require("snacks").setup({
  styles = {
    lazygit = {
      height = 0,
      width = 0,
    },
  },
  picker = { layout = "telescope" },
  input = {},
  terminal = {},
})

---@diagnostic disable-next-line: param-type-mismatch
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.api.nvim_buf_get_name(0) == "" and not vim.bo.modified then
      Snacks.picker.files({ hidden = true })
    end
  end,
})

local opts = require("opts")

local snacks_wrapper = function(fn, config)
  return function()
    fn(config)
  end
end

vim.keymap.set("n", "<leader>gg", snacks_wrapper(Snacks.lazygit), opts)
vim.keymap.set("n", "<leader>ff", snacks_wrapper(Snacks.picker.files, { hidden = true }), opts)
vim.keymap.set("n", "<leader>fb", snacks_wrapper(Snacks.picker.buffers, { hidden = true }), opts)
vim.keymap.set("n", "<leader>fg", snacks_wrapper(Snacks.picker.grep, { hidden = true }), opts)
vim.keymap.set(
  "n",
  "<leader>fd",
  snacks_wrapper(Snacks.picker.diagnostics, { hidden = true }),
  opts
)
