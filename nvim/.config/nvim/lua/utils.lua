-- Helper functions used by mappings.lua (kept here so the mappings file stays one line per key)
local M = {}

local function is_float(win)
  return vim.api.nvim_win_get_config(win or 0).relative ~= ""
end

-- Close the buffer; when it was the last one, show the dashboard instead of NvChad's empty
-- [No Name] buffer (the dashboard takes over that buffer and makes it unlisted)
function M.close_buffer()
  local was_last = #vim.t.bufs <= 1
  require("nvchad.tabufline").close_buffer()
  if was_last and vim.bo.buftype == "" and vim.api.nvim_buf_get_name(0) == "" then
    Snacks.dashboard { buf = 0, win = 0 }
    -- drop it from the buffer bar too (NvChad only updates vim.t.bufs on buffer events)
    vim.t.bufs = vim.tbl_filter(function(b)
      return vim.bo[b].buflisted
    end, vim.t.bufs)
    vim.cmd.redrawtabline()
  end
end

-- Buffer cycling ("next" / "prev"). From a terminal it just goes back to the file window;
-- ignored in floating windows (Lazy, Mason...), where NvChad's version would load a regular
-- buffer inside the float and break it
local function cycle_buffers(direction)
  if vim.bo.buftype == "terminal" then
    vim.cmd "wincmd p"
  elseif not is_float() then
    require("nvchad.tabufline")[direction]()
  end
end

function M.next_buffer()
  cycle_buffers "next"
end

function M.prev_buffer()
  cycle_buffers "prev"
end

-- gf that never opens inside floating windows (Lazy, Mason...): close the float first.
-- Directories open in the snacks explorer (it replaces netrw)
function M.goto_file()
  if not is_float() then
    vim.cmd "normal! gf"
    return
  end

  local target = vim.fn.expand "<cfile>" -- path under the cursor
  -- resolve it like gf does, before closing the float
  local path = vim.fn.isdirectory(target) == 1 and target or vim.fn.findfile(target)
  vim.cmd.close()
  if path ~= "" then
    vim.cmd.edit(path)
  end
end

return M
