require "nvchad.autocmds"

-- Show command autocomplete suggestions as you type
vim.api.nvim_create_autocmd("CmdlineChanged", {
  pattern = { ":", "/", "?" },
  callback = function()
    vim.fn.wildtrigger()
  end,
})

-- Disable NvChad's reload-on-save of config files: it reloads every "nvchad.*" module,
-- use :restart instead
vim.schedule(function()
  pcall(vim.api.nvim_del_augroup_by_name, "ReloadNvChad")
end)
