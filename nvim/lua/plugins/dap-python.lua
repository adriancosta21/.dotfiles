return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "mfussenegger/nvim-dap-python",
  },
  config = function()
    local dap = require("dap")
    local dap_python = require("dap-python")
    dap_python.setup("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")

    dap.configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}", -- roda o arquivo atual
        pythonPath = function()
          return "/usr/bin/python" -- ou use a venv se quiser
        end,
      },
    }
  end,
}
