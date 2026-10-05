require "nvchad.autocmds"

-- Show command autocomplete suggestions as you type
vim.api.nvim_create_autocmd("CmdlineChanged", {
  pattern = { ":", "/", "?" },
  callback = function()
    vim.fn.wildtrigger()
  end,
})

-- Briefly highlight yanked text (color: YankHighlight in chadrc.lua)
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank { higroup = "YankHighlight", timeout = 200 }
  end,
})

-- Redraw the statusline when a macro recording starts/stops (its "macro" module, see chadrc.lua).
vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
  callback = function()
    vim.schedule(function()
      vim.cmd.redrawstatus()
    end)
  end,
})

-- Terminal windows keep their terminal: if any command (:edit, pickers, gf...) opens another
-- buffer in one, put the terminal back and show that buffer in the previous (file) window
-- (TermOpen too: a new terminal is shown first as an empty buffer, then turned into a terminal)
vim.api.nvim_create_autocmd({ "TermOpen", "BufWinEnter" }, {
  group = vim.api.nvim_create_augroup("user.term_keep", { clear = true }),
  callback = function(ev)
    local win = vim.api.nvim_get_current_win()
    if vim.bo[ev.buf].buftype == "terminal" then
      vim.w[win].term_buf = ev.buf -- remember which terminal this window shows
    elseif vim.w[win].term_buf and vim.api.nvim_buf_is_valid(vim.w[win].term_buf) then
      -- scheduled: switching buffers inside BufWinEnter itself can confuse Neovim
      vim.schedule(function()
        vim.api.nvim_win_set_buf(win, vim.w[win].term_buf)
        -- target: the previous window if it's a file window, else the first one found
        -- (after a picker closes, the "previous" window is the picker's, already gone)
        local wins = vim.api.nvim_tabpage_list_wins(0)
        table.insert(wins, 1, vim.fn.win_getid(vim.fn.winnr "#"))
        for _, w in ipairs(wins) do
          if
            vim.api.nvim_win_is_valid(w)
            and not vim.w[w].term_buf
            and vim.api.nvim_win_get_config(w).relative == ""
          then
            vim.api.nvim_win_set_buf(w, ev.buf)
            vim.api.nvim_set_current_win(w)
            return
          end
        end
      end)
    end
  end,
})

-- Disable NvChad's reload-on-save of config files: it reloads every "nvchad.*" module,
-- use :restart instead
vim.schedule(function()
  pcall(vim.api.nvim_del_augroup_by_name, "ReloadNvChad")
end)
