require "nvchad.options"

local o = vim.o
o.wildmode = "noselect:lastused,full"
o.relativenumber = true
o.showcmd = false -- it was breaking the layout
