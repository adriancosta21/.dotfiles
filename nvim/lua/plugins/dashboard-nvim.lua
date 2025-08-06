return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    dashboard = {
      sections = {
        -- Coluna da esquerda: Imagem grande em ASCII
        {
          row = 1,
          pane = 1,
          section = "terminal",
          cmd = "ascii-image-converter ~/Pictures/eva-cross.jpg -C -d 40,20",
          height = 20,
          padding = 1,
        },

        -- Coluna da direita: atalhos e listas
        {
          row = 1,
          pane = 2,
          section = "keys",
          gap = 1,
          padding = 1,
        },
        {
          row = 1,
          pane = 2,
          icon = " ",
          title = "Recent Files",
          section = "recent_files",
          indent = 2,
          padding = 1,
        },
        {
          row = 1,
          pane = 2,
          icon = " ",
          title = "Projects",
          section = "projects",
          indent = 2,
          padding = 1,
        },
        {
          row = 1,
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
      },
    },
  },
}
