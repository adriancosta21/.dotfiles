return {
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      opts = {
        enable_close = true, -- Auto close tags
        enable_rename = true, -- Legacy option (compatibility)
        enable_close_on_slash = true,
      },

      auto_rename = {
        enabled = true, -- Live rename paired tags
      },
    },
  },
}
