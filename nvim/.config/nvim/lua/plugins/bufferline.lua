return {
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        -- Numbers on buffers
        numbers = "ordinal",

        mouse = "left", -- Allow mouse left click
        move_wraps_at_ends = true,
        separator_style = "thin",
      },
    },

    keys = {
      -- Picking
      {
        "<leader>bj",
        "<cmd>BufferLinePick<cr>",
        desc = "Pick Buffer",
      },

      -- Pinning
      {
        "<leader>bp",
        "<cmd>BufferLineTogglePin<cr>",
        desc = "Toggle Pin",
      },

      -- Reordering
      -- Move buffer left
      {
        "<leader>b[",
        "<cmd>BufferLineMovePrev<cr>",
        desc = "Move buffer left",
      },
      {
        "<C-[>",
        "<cmd>BufferLineMovePrev<cr>",
        desc = "Move buffer left",
      },
      -- Move buffer right
      {
        "<C-]>",
        "<cmd>BufferLineMoveNext<cr>",
        desc = "Move buffer right",
      },
      {
        "<leader>b]",
        "<cmd>BufferLineMoveNext<cr>",
        desc = "Move buffer right",
      },
    },
  },
}
