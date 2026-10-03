-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "tokyonight",
  transparency = true,
  integrations = { "rainbowdelimiters" },
  hl_override = {
    Search = { fg = "black", bg = "yellow" },
    IncSearch = { fg = "black", bg = "yellow" },
  },
  -- groups the theme doesn't define (CurSearch also colors hlslens "near" groups via link)
  hl_add = {
    CurSearch = { fg = "black", bg = "blue" },
    HlSearchLens = { fg = "black", bg = "yellow" },
  },
}

M.ui = {
  tabufline = {
    -- default order without "btns" (theme toggle + close all buttons)
    order = { "treeOffset", "buffers", "tabs" },
  },
}

return M
