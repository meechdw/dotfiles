return {
  {
    "echasnovski/mini.icons",
    opts = {},
    lazy = true,
    specs = {
      { "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
  {
    "echasnovski/mini.files",
    keys = {
      {
        "<leader>n",
        function()
          if vim.bo.filetype == "minifiles" then
            vim.cmd("lua MiniFiles.close()")
          else
            vim.cmd("lua MiniFiles.open()")
          end
        end,
      },
    },
    opts = {
      mappings = {
        synchronize = ":",
      },
      options = {
        permanent_delete = false,
      },
    },
  },
}
