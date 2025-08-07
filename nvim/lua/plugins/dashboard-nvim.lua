return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    dashboard = {
      sections = {
        -- Imagem ASCII grande à esquerda
        {
          row = 1,
          pane = 1,
          section = "terminal",
          cmd = "ascii-image-converter ~/Pictures/eva-cross.jpg -C",
          height = 20,
          padding = 1,
          scrollable = false,
        },

        -- Botões personalizados na direita

        -- Outras seções na coluna da direita
        { row = 2, pane = 2, icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
        {
          row = 2,
          pane = 2,
          icon = " ",
          title = "Projects",
          section = "projects",
          indent = 2,
          padding = 1,
        },
        {
          row = 2,
          pane = 2,
          icon = " ",
          title = "Git Status",
          section = "terminal",
          enabled = function()
            return Snacks.git.get_root() ~= nil
          end,
          cmd = "git status --short --branch --renames",
          height = 5,
          padding = 1,
          ttl = 5 * 60,
          indent = 3,
        },

        -- Tempo de carregamento do Neovim
        {
          row = 1,
          pane = 1,
          section = "startup",
          padding = 1,
        },
      },
    },
  },
}
