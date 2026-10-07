require "nvchad.mappings"

local map = vim.keymap.set
local utils = require "utils" -- helper functions (lua/utils.lua)

-- REMAPS
vim.keymap.del("v", "<leader>/") -- used to comment line, <leader>gc is used instead. Will be used as grep
vim.keymap.del("n", "<C-n>") -- used to toggle the file explorer, <leader>e is used instead
vim.keymap.del("n", "<leader>b") -- used to create a new buffer; <leader>b is now the buffer group
vim.keymap.del("n", "<leader>x") -- used to close the buffer, <leader>bd is used instead
vim.keymap.del("n", "<leader>ds") -- diagnostics loclist, <leader>dX is used instead
vim.keymap.del("n", "<leader>gt") -- telescope git status, <leader>gs is used instead

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

-- GO TO (<leader>g group): pick a diagnostic / changed file and jump to it
require("which-key").add { { "<leader>g", group = "go to" } }
map("n", "<leader>gs", "<cmd> Telescope git_status <cr>", { desc = "Git status (changed files)" })
map("n", "<leader>gd", function()
  Snacks.picker.diagnostics()
end, { desc = "Diagnostics (all open files)" })
map("n", "<leader>gD", function()
  Snacks.picker.diagnostics_buffer()
end, { desc = "Diagnostics (current file)" })

-- CODE (<leader>c group)
require("which-key").add { { "<leader>c", group = "code" } }
map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
map("n", "<leader>cA", utils.lsp_action "source", { desc = "Source actions (whole file)" })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "<leader>co", utils.lsp_action "source.organizeImports", { desc = "Organize imports" })
map("n", "<leader>cM", utils.lsp_action "source.addMissingImports.ts", { desc = "Add missing imports" })
map("n", "<leader>cu", utils.lsp_action "source.removeUnused.ts", { desc = "Remove unused imports" })
map("n", "<leader>cD", utils.lsp_action "source.fixAll.ts", { desc = "Fix all diagnostics" })

-- DEBUG (<leader>d group): diagnostics in native quickfix/location list windows (like LazyVim's
-- Trouble), regular buffers you can copy from; <CR> jumps to the error. Only open files
require("which-key").add { { "<leader>d", group = "debug" } }
map("n", "<leader>dx", vim.diagnostic.setqflist, { desc = "Diagnostics list (all open files)" })
map("n", "<leader>dX", vim.diagnostic.setloclist, { desc = "Diagnostics list (current file)" })

-- BUFFERS (<leader>b group, LazyVim style)
require("which-key").add { { "<leader>b", group = "buffer" } }
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to other buffer" })
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
-- needs kitty (no_op) + tmux (extended-keys) to pass Ctrl+Shift through, see their configs
map("n", "<C-S-h>", function() -- move buffer left
  require("nvchad.tabufline").move_buf(-1)
end, { desc = "Move buffer left" })
map("n", "<C-S-l>", function()
  require("nvchad.tabufline").move_buf(1) -- move buffer right
end, { desc = "Move buffer right" })
map("n", "<Tab>", utils.next_buffer, { desc = "buffer goto next" })
map("n", "<S-Tab>", utils.prev_buffer, { desc = "buffer goto prev" })

-- CTRL mappings
map({ "n", "x" }, "<C-a>", "<Esc>gg0VG$", { desc = "Select all text" })
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "Save file" })
map({ "n", "t" }, "<C-/>", "<A-h>", { desc = "Toggle horizontal terminal", remap = true })
