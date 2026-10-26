-- Debugger (DAP) with VS Code keybindings
-- adapters are installed through Mason; mason-nvim-dap sets up adapter + default configurations
-- for every installed one, so a new language only needs :DapInstall <name> (or :Mason)

-- keymap callback that loads nvim-dap and calls one of its functions
local function dap_call(fn)
  return function()
    require("dap")[fn]()
  end
end

-- debug the current file without the configuration picker:
-- C/C++ run the executable with the buffer's name next to it, other languages use their "${file}" launch config
local function debug_file()
  local dap = require "dap"
  local ft = vim.bo.filetype
  local cfg

  if ft == "c" or ft == "cpp" then
    local exe = vim.fn.expand "%:p:r"
    if vim.fn.executable(exe) == 0 then
      return vim.notify("Executable not found: " .. exe, vim.log.levels.ERROR)
    end
    if vim.fn.getftime(vim.fn.expand "%:p") > vim.fn.getftime(exe) then
      vim.notify("Executable is older than the source, recompile it", vim.log.levels.WARN)
    end
    cfg = vim.tbl_extend("force", (dap.configurations[ft] or {})[1] or {}, { program = exe, args = {} })
  else
    for _, c in ipairs(dap.configurations[ft] or {}) do
      if c.request == "launch" and c.program == "${file}" then
        cfg = c
        break
      end
    end
  end

  if not cfg or not cfg.type then
    return vim.notify("No debug configuration for filetype: " .. ft, vim.log.levels.ERROR)
  end
  dap.run(cfg)
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
    init = function()
      -- clicking the line number (gutter) toggles a breakpoint on that line, like VS Code
      vim.keymap.set("n", "<LeftMouse>", function()
        local pos = vim.fn.getmousepos()
        local win = pos.winid ~= 0 and vim.fn.getwininfo(pos.winid)[1]
        if win and pos.line > 0 and pos.wincol <= win.textoff and vim.bo[win.bufnr].buftype == "" then
          vim.api.nvim_set_current_win(pos.winid)
          vim.api.nvim_win_set_cursor(pos.winid, { pos.line, 0 })
          require("dap").toggle_breakpoint()
        else
          vim.api.nvim_feedkeys(vim.keycode "<LeftMouse>", "n", false) -- regular click
        end
      end, { desc = "Toggle breakpoint on line number click" })
    end,
    keys = {
      { "<leader>db", dap_call "toggle_breakpoint", desc = "Toggle breakpoint" },
      { "<leader>df", debug_file, desc = "Debug current file" },
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
