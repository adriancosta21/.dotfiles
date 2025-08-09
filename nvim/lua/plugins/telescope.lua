local telescope_builtin = require("telescope.builtin")

return {
  "nvim-telescope/telescope.nvim",
  keys = {
    {
      "<leader><leader>",
      function()
        telescope_builtin.find_files({
          hidden = false,
          no_ignore = false,
          layout_config = {
            prompt_position = "top", -- Coloca o prompt no topo
          },
          layout_strategy = "horizontal",
          sorting_strategy = "ascending",
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
          layout_config = {
            prompt_position = "top", -- Coloca o prompt no topo
          },
          layout_strategy = "horizontal",
          sorting_strategy = "ascending",
        })
      end,
      desc = "Find files (root dir, show hidden, prompt top)",
    },
  },
}
