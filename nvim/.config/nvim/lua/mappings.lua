require "nvchad.mappings"

local map = vim.keymap.set

-- REMAPS
vim.keymap.del("v", "<leader>/") -- used to comment line, <leader>gc is used instead. Will be used as grep
vim.keymap.del("n", "<C-n>") -- used to toggle nvim-tree, <leader>e is used instead

-- INSERT mode
map("i", "jk", "<ESC>") -- bind jk as ESC sequence

-- NORMAL mode
map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<leader><leader>", "<cmd> Telescope find_files <cr>", { desc = "Find files" })
map("n", "<leader>e", "<cmd> NvimTreeToggle <cr>", { desc = "Toggle file explorer" })
map("n", "<leader>/", "<cmd> Telescope live_grep <cr>", { desc = "Telescope live grep" })
map({ "n", "x" }, "<leader>gc", "gc", { desc = "Toggle comment", remap = true })

-- CTRL mappings
map({ "n", "x" }, "<C-a>", "<Esc>gg0VG$", { desc = "Select all text" })
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "Save file" })
map({ "n", "t" }, "<C-/>", "<A-h>", { desc = "Toggle horizontal terminal", remap = true })
