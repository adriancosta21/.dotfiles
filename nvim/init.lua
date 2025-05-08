-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.options")
require("config.highlights")
vim.keymap.set("i", "jk", "<Esc>", { noremap = true })
vim.keymap.set("v", "jk", "<Esc>", { noremap = true })
vim.keymap.set("t", "jk", "<C-\\><C-n>", { noremap = true })
-- Aplica transparência global após carregar o colorscheme
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    -- Grupos básicos para janelas normais e flutuantes
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

    -- Grupos específicos para file explorers (adicione conforme necessário)
    local transparent_groups = {
      -- NvimTree
      "NvimTreeNormal",
      "NvimTreeNormalNC",
      "NvimTreeEndOfBuffer",
      -- Neo-tree
      "NeoTreeNormal",
      "NeoTreeNormalNC",
      "NeoTreeEndOfBuffer",
      -- Oil.nvim
      "OilDir",
      "OilFile",
      -- Outros plugins
      "TelescopeNormal",
      "TelescopeBorder",
      "TelescopePromptNormal",
      "LazyNormal",
      "MasonNormal",
      "WhichKeyFloat",
    }

    for _, group in ipairs(transparent_groups) do
      vim.api.nvim_set_hl(0, group, { bg = "none" })
    end
  end,
})
