return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    dashboard = {
      sections = {
        -- Keymaps
        {
          row = 1,
          pane = 1,
          icon = " ",
          title = "Keymaps",
          section = "keys",
          indent = 2,
          padding = 1,
        },

        -- Projetos
        {
          row = 2,
          pane = 1,
          icon = " ",
          title = "Projects",
          section = "projects",
          indent = 2,
          padding = 1,
        },

        -- Status do Git
        {
          row = 3,
          pane = 1,
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

        -- Tempo de carregamento do Neovim (agora por último)
        {
          row = 4,
          pane = 1,
          section = "startup",
          padding = 1,
        },
      },
    },
  },
}
