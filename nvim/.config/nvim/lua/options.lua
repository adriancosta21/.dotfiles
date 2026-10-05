require "nvchad.options"

local o = vim.o
o.wildmode = "noselect:lastused,full"
o.relativenumber = true
o.showcmd = false -- it was breaking the layout
vim.opt.sessionoptions:remove { "blank", "terminal" } -- don't save terminal and unnamed buffers (such as file pickers)
