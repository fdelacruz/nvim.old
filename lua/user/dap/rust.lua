-- brew install llvm

return {

  setup = function()
    local dap = require("dap")

    dap.adapters.lldb = {
      type = "executable",
      command = "/usr/local/opt/llvm/bin/lldb-vscode", -- adjust as needed
      name = "lldb",
    }

    dap.configurations.rust = {
      {
        name = "Launch",
        type = "lldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
        runInTerminal = false,
      },
    }
  end,

}
