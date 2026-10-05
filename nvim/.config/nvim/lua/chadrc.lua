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
    SnacksPickerTitle = { fg = "white", bg = "NONE" },
    YankHighlight = { fg = "black", bg = "orange" }, -- yanked text flash (see autocmds.lua)
    -- mini.icons defaults are links, and NvChad renders them as a default gray
    MiniIconsAzure = { fg = "nord_blue" },
    MiniIconsBlue = { fg = "blue" },
    MiniIconsCyan = { fg = "cyan" },
    MiniIconsGreen = { fg = "green" },
    MiniIconsGrey = { fg = "light_grey" },
    MiniIconsOrange = { fg = "orange" },
    MiniIconsPurple = { fg = "purple" },
    MiniIconsRed = { fg = "red" },
    MiniIconsYellow = { fg = "yellow" },
    St_Macro = { fg = "red" }, -- macro recording indicator (statusline "macro" module)
  },
}

M.ui = {
  tabufline = {
    -- Overwrite to remove top right buttons and left padding for file explorer (it now opens on the right side)
    order = { "buffers", "tabs" },
  },
  statusline = {
    -- default order + "macro" after the mode: with cmdheight = 0 (tiny-cmdline) and
    -- showmode off (NvChad), "recording @q" has nowhere else to show up
    order = { "mode", "macro", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "cursor" },
    modules = {
      macro = function()
        local reg = vim.fn.reg_recording()
        return reg ~= "" and ("%#St_Macro# 󰑋 @" .. reg .. " ") or ""
      end,
    },
  },
}

return M
