return {
  "stevearc/oil.nvim",
  lazy = false,
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  opts = {
    skip_confirm_for_simple_edits = true,
    view_options = { show_hidden = true },
  },
  keys = {
    {
      "<leader>n",
      function()
        if vim.bo.filetype == "oil" then
          local oil_buf = vim.api.nvim_get_current_buf()
          local alt_buf = vim.fn.bufnr("#")

          if alt_buf ~= -1 and vim.fn.buflisted(alt_buf) == 1 then
            vim.cmd.buffer(alt_buf)
          else
            vim.cmd("enew")
          end

          vim.cmd("bdelete " .. oil_buf)
        else
          vim.cmd("Oil")
        end
      end,
    },
  },
}
