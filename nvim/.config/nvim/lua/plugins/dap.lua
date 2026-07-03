return {
  {
    "rcarriga/nvim-dap-ui",
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      -- event_terminated and event_exited listeners intentionally omitted
      -- so the UI stays open after the session ends (close manually with <leader>du)
    end,
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      local function bp_file()
        local hash = vim.fn.sha256(vim.fn.getcwd()):sub(1, 8)
        return vim.fn.stdpath("data") .. "/dap_breakpoints/" .. hash .. ".json"
      end

      local function save_breakpoints()
        local data = {}
        for bufnr, bps in pairs(require("dap").breakpoints.get()) do
          local name = vim.api.nvim_buf_get_name(bufnr)
          if name ~= "" then
            data[name] = bps
          end
        end
        local path = bp_file()
        vim.fn.mkdir(vim.fn.fnamemodify(path, ":h"), "p")
        local f = io.open(path, "w")
        if f then
          f:write(vim.fn.json_encode(data))
          f:close()
        end
      end

      local saved = nil
      local function get_saved()
        if saved then
          return saved
        end
        local f = io.open(bp_file(), "r")
        if not f then
          saved = {}
          return saved
        end
        local ok, decoded = pcall(vim.fn.json_decode, f:read("*a"))
        f:close()
        saved = ok and decoded or {}
        return saved
      end

      local function load_for_buf(bufnr)
        local name = vim.api.nvim_buf_get_name(bufnr)
        local bps = get_saved()[name]
        if not bps then
          return
        end
        local breakpoints = require("dap").breakpoints
        for _, bp in ipairs(bps) do
          breakpoints.set({
            condition = bp.condition,
            log_message = bp.logMessage,
            hit_condition = bp.hitCondition,
          }, bufnr, bp.line)
        end
      end

      vim.api.nvim_create_autocmd("VimLeavePre", { callback = save_breakpoints })
      vim.api.nvim_create_autocmd("BufReadPost", {
        callback = function(args)
          load_for_buf(args.buf)
        end,
      })
    end,
  },
}
