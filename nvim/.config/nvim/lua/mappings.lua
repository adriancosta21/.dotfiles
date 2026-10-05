require "nvchad.mappings"

local map = vim.keymap.set

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

-- buffer group (<leader>b, LazyVim style)
require("which-key").add { { "<leader>b", group = "buffer" } }
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to other buffer" })
map("n", "<leader>bd", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "Delete buffer" })
map("n", "<leader>bo", function()
  require("nvchad.tabufline").closeAllBufs(false)
end, { desc = "Delete other buffers" })
map("n", "<leader>bl", function()
  require("nvchad.tabufline").closeBufs_at_direction "left"
end, { desc = "Delete buffers to the left" })
map("n", "<leader>br", function()
  require("nvchad.tabufline").closeBufs_at_direction "right"
end, { desc = "Delete buffers to the right" })

-- Buffer cycling, ignored in floating windows (Lazy, Mason...): NvChad's version would
-- load a regular buffer inside the float and break it
map("n", "<Tab>", function()
  if vim.bo.buftype == "terminal" then
    vim.cmd "wincmd p" -- from the terminal, just go back to the file window
  elseif vim.api.nvim_win_get_config(0).relative == "" then
    require("nvchad.tabufline").next()
  end
end, { desc = "buffer goto next" })
map("n", "<S-Tab>", function()
  if vim.bo.buftype == "terminal" then
    vim.cmd "wincmd p" -- from the terminal, just go back to the file window
  elseif vim.api.nvim_win_get_config(0).relative == "" then
    require("nvchad.tabufline").prev()
  end
end, { desc = "buffer goto prev" })

-- gf: never open inside floating windows (Lazy, Mason...): close the float first.
-- Directories open in the snacks explorer (it replaces netrw)
map("n", "gf", function()
  if vim.api.nvim_win_get_config(0).relative == "" then
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
end, { desc = "Go to file (never inside floats)" })

-- CTRL mappings
map({ "n", "x" }, "<C-a>", "<Esc>gg0VG$", { desc = "Select all text" })
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "Save file" })
map({ "n", "t" }, "<C-/>", "<A-h>", { desc = "Toggle horizontal terminal", remap = true })
