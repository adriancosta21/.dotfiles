-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.number = true
vim.opt.relativenumber = true

-- Cor dos números relativos (LineNr) = azul
vim.cmd([[
  highlight LineNr guifg=#569CD6
]])

-- Opcional: manter a linha atual (CursorLineNr) em amarelo/destaque
vim.cmd([[
  highlight CursorLineNr guifg=#FFD700
]])
