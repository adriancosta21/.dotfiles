return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      "<leader><leader>",
      function()
        require("telescope.builtin").find_files({
          hidden = false,
          no_ignore = false,
          layout_config = {
            prompt_position = "top", -- Coloca o prompt no topo
          },
          layout_strategy = "horizontal",
          sorting_strategy = "ascending",
        })
      end,
      desc = "Find files (root dir, no hidden, prompt top)",
    },
    {
      "<leader>ff",
      function()
        require("telescope.builtin").find_files({
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
  config = function()
    -- Configuração opcional extra
    require("telescope").setup({
      defaults = {
        layout_config = {
          prompt_position = "top",
        },
        layout_strategy = "horizontal",
        sorting_strategy = "ascending",
      },
    })
  end,
}
