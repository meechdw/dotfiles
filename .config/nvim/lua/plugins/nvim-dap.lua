return {
  "mfussenegger/nvim-dap",
  dependencies = {
    { "theHamsta/nvim-dap-virtual-text" },
    { "rcarriga/nvim-dap-ui" },
    { "nvim-neotest/nvim-nio" },
  },
  keys = {
    { "<leader>db", "<cmd>DapToggleBreakpoint<cr>" },
    { "<leader>dx", "<cmd>DapClearBreakpoints<cr>" },
    { "<leader>dc", "<cmd>DapContinue<cr>" },
    { "<leader>ds", "<cmd>DapStepOver<cr>" },
    { "<leader>di", "<cmd>DapStepInto<cr>" },
    { "<leader>du", "<cmd>DapStepOut<cr>" },
    { "<leader>dw", "<cmd>DapTerminate<cr>" },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup()
    require("nvim-dap-virtual-text").setup()

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    dap.adapters = {
      lldb = {
        type = "executable",
        command = "/opt/homebrew/opt/llvm/bin/lldb-dap",
        name = "lldb",
      },
    }

    dap.configurations.cpp = {
      {
        name = "Launch",
        type = "lldb",
        request = "launch",
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        program = function()
          return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        args = function()
          local input = vim.fn.input("Arguments: ")
          return vim.split(input, " ", { trimempty = true })
        end,
      },
    }

    dap.configurations.zig = {
      {
        name = "Launch",
        type = "lldb",
        request = "launch",
        cwd = "${workspaceFolder}",
        program = function()
          return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        args = function()
          local input = vim.fn.input("Arguments: ")
          return vim.split(input, " ", { trimempty = true })
        end,
      },
    }

    dap.configurations.scala = {
      {
        name = "RunOrTest",
        type = "scala",
        request = "launch",
        metals = {
          runType = "runOrTestFile",
        },
      },
      {
        name = "Test Target",
        type = "scala",
        request = "launch",
        metals = {
          runType = "testTarget",
        },
      },
    }
  end,
}
