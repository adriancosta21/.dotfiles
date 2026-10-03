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

-- Buffer cycling, ignored in floating windows (Lazy, Mason...): NvChad's version would
-- load a regular buffer inside the float and break it
map("n", "<Tab>", function()
  if vim.api.nvim_win_get_config(0).relative == "" then
    require("nvchad.tabufline").next()
  end
end, { desc = "buffer goto next" })
map("n", "<S-Tab>", function()
  if vim.api.nvim_win_get_config(0).relative == "" then
    require("nvchad.tabufline").prev()
  end
end, { desc = "buffer goto prev" })

-- gf: open directories in nvim-tree (netrw is disabled) and never inside floating windows
map("n", "gf", function()
  local target = vim.fn.expand "<cfile>" -- path under the cursor
  local in_float = vim.api.nvim_win_get_config(0).relative ~= ""

  if vim.fn.isdirectory(target) == 1 then
    if in_float then
      vim.cmd.close()
    end
    require("nvim-tree.api").tree.open { path = target }
  elseif in_float then
    local file = vim.fn.findfile(target) -- resolve it like gf does, before closing the float
    vim.cmd.close()
    if file ~= "" then
      vim.cmd.edit(file)
    end
  else
    vim.cmd "normal! gf"
  end
end, { desc = "Go to file (directories in nvim-tree)" })

-- CTRL mappings
map({ "n", "x" }, "<C-a>", "<Esc>gg0VG$", { desc = "Select all text" })
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "Save file" })
map({ "n", "t" }, "<C-/>", "<A-h>", { desc = "Toggle horizontal terminal", remap = true })
