return {
  {
    "folke/tokyonight.nvim",
    config = function()
      require("tokyonight").setup({
        style = "storm",
        light_style = "day",
        transparent = true,
        terminal_colors = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
        day_brightness = 0.3,
        dim_inactive = false,
        lualine_bold = false,
        on_colors = function(colors) end,
        on_highlights = function(highlights, colors)
          highlights.NeoTreeNormal = { bg = "NONE" }
          highlights.NeoTreeNormalNC = { bg = "NONE" }
        end,
        plugins = nil,
        cache = false,
      })
      vim.cmd([[colorscheme tokyonight]])
    end,
    priority = 1000,
  },
}
