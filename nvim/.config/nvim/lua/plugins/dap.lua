-- Debugger (DAP) with VS Code keybindings
-- adapters are installed through Mason; mason-nvim-dap sets up adapter + default configurations
-- for every installed one, so a new language only needs :DapInstall <name> (or :Mason)

-- keymap callback that loads nvim-dap and calls one of its functions
local function dap_call(fn)
  return function()
    require("dap")[fn]()
  end
end

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio", -- required by nvim-dap-ui
      "mason-org/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",
    },
    cmd = { "DapInstall", "DapUninstall" },
    keys = {
      { "<leader>db", dap_call "toggle_breakpoint", desc = "Toggle breakpoint" },
      { "<F5>", dap_call "continue", desc = "Debug: start/continue" },
      { "<S-F5>", dap_call "terminate", desc = "Debug: stop" },
      { "<C-S-F5>", dap_call "restart", desc = "Debug: restart" },
      { "<F10>", dap_call "step_over", desc = "Debug: step over" },
      { "<F11>", dap_call "step_into", desc = "Debug: step into" },
      { "<S-F11>", dap_call "step_out", desc = "Debug: step out" },
      -- same keys as terminals without the kitty keyboard protocol send them (Shift = +12, Ctrl+Shift = +36)
      { "<F17>", dap_call "terminate", desc = "Debug: stop" }, -- Shift <F5>
      { "<F41>", dap_call "restart", desc = "Debug: restart" }, -- Ctrl+Shift <F5>
      { "<F23>", dap_call "step_out", desc = "Debug: step out" }, -- Shift <F11>
      {
        "<leader>du",
        function()
          require("dapui").toggle()
        end,
        desc = "Toggle debugger UI",
      },
    },
    config = function()
      local dap, dapui = require "dap", require "dapui"

      require("mason-nvim-dap").setup {
        ensure_installed = { "js", "codelldb", "python" }, -- node, C/C++/Rust, python
        automatic_installation = false,
        handlers = {
          -- default: adapter + configurations shipped by mason-nvim-dap (python, codelldb, ...)
          function(config)
            require("mason-nvim-dap").default_setup(config)
          end,
          -- mason-nvim-dap has no defaults for js-debug-adapter, so define them here
          js = function()
            dap.adapters["pwa-node"] = {
              type = "server",
              host = "localhost",
              port = "${port}",
              executable = {
                command = vim.fn.stdpath "data" .. "/mason/bin/js-debug-adapter",
                args = { "${port}" },
              },
            }
            for _, ft in ipairs { "javascript", "typescript", "javascriptreact", "typescriptreact" } do
              dap.configurations[ft] = {
                {
                  type = "pwa-node",
                  request = "launch",
                  name = "Node: Launch file",
                  program = "${file}", -- node runs .ts directly (type stripping)
                  cwd = "${workspaceFolder}",
                },
                {
                  type = "pwa-node",
                  request = "attach",
                  name = "Node: Attach to process",
                  processId = require("dap.utils").pick_process,
                  cwd = "${workspaceFolder}",
                },
              }
            end
          end,
        },
      }

      dapui.setup()
      -- open the panels when a session starts 
      dap.listeners.before.attach.dapui_config = dapui.open
      dap.listeners.before.launch.dapui_config = dapui.open

      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn" })
      vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticOk", linehl = "Visual" })
    end,
  },
}
