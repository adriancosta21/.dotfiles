require "nvchad.mappings"

local map = vim.keymap.set
local utils = require "utils" -- helper functions (lua/utils.lua)

-- REMAPS
vim.keymap.del("v", "<leader>/") -- used to comment line, <leader>gc is used instead. Will be used as grep
vim.keymap.del("n", "<C-n>") -- used to toggle the file explorer, <leader>e is used instead
vim.keymap.del("n", "<leader>b") -- used to create a new buffer; <leader>b is now the buffer group

-- INSERT mode
map("i", "jk", "<ESC>") -- bind jk as ESC sequence

-- NORMAL mode
map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<leader><leader>", "<cmd> Telescope find_files <cr>", { desc = "Find files" })
map("n", "<leader>e", function()
  Snacks.explorer()
end, { desc = "Toggle file explorer" })
map("n", "<leader>/", "<cmd> Telescope live_grep <cr>", { desc = "Telescope live grep" })
map({ "n", "x" }, "<leader>gc", "gc", { desc = "Toggle comment", remap = true })
map("n", "gf", utils.goto_file, { desc = "Go to file (never inside floats)" })

-- BUFFERS (<leader>b group, LazyVim style)
require("which-key").add { { "<leader>b", group = "buffer" } }
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to other buffer" })
map("n", "<leader>x", utils.close_buffer, { desc = "Delete buffer" })
map("n", "<leader>bd", utils.close_buffer, { desc = "Delete buffer" })
map("n", "<leader>bo", function()
  require("nvchad.tabufline").closeAllBufs(false)
end, { desc = "Delete other buffers" })
map("n", "<leader>bl", function()
  require("nvchad.tabufline").closeBufs_at_direction "left"
end, { desc = "Delete buffers to the left" })
map("n", "<leader>br", function()
  require("nvchad.tabufline").closeBufs_at_direction "right"
end, { desc = "Delete buffers to the right" })
map("n", "<Tab>", utils.next_buffer, { desc = "buffer goto next" })
map("n", "<S-Tab>", utils.prev_buffer, { desc = "buffer goto prev" })

-- CTRL mappings
map({ "n", "x" }, "<C-a>", "<Esc>gg0VG$", { desc = "Select all text" })
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "Save file" })
map({ "n", "t" }, "<C-/>", "<A-h>", { desc = "Toggle horizontal terminal", remap = true })
