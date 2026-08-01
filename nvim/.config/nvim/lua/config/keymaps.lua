-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set

-- Ctrl + A select all
map("n", "<C-a>", "gg0VG$", { desc = "Select All" })

-- Ctrl+C to copy text on Visual mode
map("v", "<C-c>", '"+y', { desc = "Copy to system clipboard" })

-- Ctrl+V to paste text on Normal mode
map("n", "<C-v>", '"+p', { desc = "Paste from system clipboard" })

-- Ctrl+Tab to switch to last used buffer
map("n", "<F13>", "<cmd>b#<CR>", { desc = "Switch to last buffer" })
-- DAP F-keys, all modes (besides default bindings)
vim.keymap.set("", "<F4>", function()
  require("dap").terminate()
end, { desc = "DAP Terminate" })
vim.keymap.set("", "<F5>", function()
  require("dap").continue()
end, { desc = "DAP Continue" })
vim.keymap.set("", "<F6>", function()
  require("dap").step_over()
end, { desc = "DAP Step Over" })
vim.keymap.set("", "<F7>", function()
  require("dap").step_into()
end, { desc = "DAP Step Into" })
vim.keymap.set("", "<F8>", function()
  require("dap").step_out()
end, { desc = "DAP Step Out" })
vim.keymap.set("", "<F9>", function()
  require("dap").toggle_breakpoint()
end, { desc = "DAP Toggle Breakpoint" })

-- <leader> ct toggles blink completion menu
map("n", "<leader>ct", function()
  vim.b.completion = not (vim.b.completion ~= false)

  if not vim.b.completion then
    require("blink.cmp").hide()
  end

  vim.notify("Completion " .. (vim.b.completion and "enabled" or "disabled"))
end, { desc = "Toggle completion" })
