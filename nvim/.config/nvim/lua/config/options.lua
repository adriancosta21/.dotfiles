-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.number = true
vim.opt.relativenumber = true
-- Write over the original file on save (preserves the inode) instead of
-- creating a new file + renaming. Without this, inotify-based watchers
-- (e.g. node --watch) stop detecting changes after the first save.
vim.opt.backupcopy = "yes"
-- Cor dos números relativos (LineNr) = azul
vim.cmd([[
  highlight LineNr guifg=#569CD6
]])

-- Opcional: manter a linha atual (CursorLineNr) em amarelo/destaque
vim.cmd([[
  highlight CursorLineNr guifg=#FFD700
]])
