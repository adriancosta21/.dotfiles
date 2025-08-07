local telescope_builtin = require("telescope.builtin")

return {
  "nvim-telescope/telescope.nvim",
  keys = {
    {
      "<leader><leader>",
      function()
        telescope_builtin.find_files({
          hidden = true,
          no_ignore = false,
          prompt_position = "top", -- Prompt no topo
          layout_strategy = "horizontal", -- Layout horizontal clássico
          sorting_strategy = "ascending", -- Resultados de cima para baixo
        })
      end,
      desc = "Find files (root dir, show hidden, prompt top)",
    },
    {
      "<leader>ff",
      function()
        telescope_builtin.find_files({
          hidden = true,
          no_ignore = false,
          prompt_position = "top",
          layout_strategy = "horizontal",
          sorting_strategy = "ascending",
        })
      end,
      desc = "Find files (root dir, show hidden, prompt top)",
    },
  },
}
