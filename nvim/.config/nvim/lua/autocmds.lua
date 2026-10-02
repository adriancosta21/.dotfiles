require "nvchad.autocmds"

-- Show command autocomplete suggestions as you type
vim.api.nvim_create_autocmd("CmdlineChanged", {
  pattern = { ":", "/", "?" },
  callback = function()
    vim.fn.wildtrigger()
  end,
})
