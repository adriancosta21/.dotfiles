-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set

-- Ctrl + A select all
map("n", "<C-a>", "ggVG", { desc = "Select All" })

-- Ctrl+C para copiar seleção no Visual Mode
map("v", "<C-c>", '"+y', { desc = "Copy to system clipboard" })

-- Ctrl+V para colar no Normal Mode
map("n", "<C-v>", '"+p', { desc = "Paste from system clipboard" })

-- Ctrl+V para colar no Insert Mode
map("i", "<C-v>", "<C-r>+", { desc = "Paste from system clipboard (insert mode)" })

-- Ctrl+V para colar no Visual Mode (substituindo seleção)
map("v", "<C-v>", '"+p', { desc = "Paste over selection from clipboard" })

-- Ctrl+Tab navega para o buffer anterior (último usado)
map("n", "<C-Tab>", "<cmd>b#<cr>", { desc = "Switch to last buffer" })
