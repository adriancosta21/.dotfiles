return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- format on save
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      pickers = {
        -- search inside hidden dirs (.config, dotfiles) but skip .git
        live_grep = {
          additional_args = { "--hidden", "-g", "!.git" },
        },
        find_files = {
          hidden = true,
          file_ignore_patterns = { "^.git/" },
        },
      },
    },
  },
  {
    "kevinhwang91/nvim-hlslens",
    opts = {},
    -- load before the first / or ? search so hlslens can catch it (keys alone only load on n/N/*)
    event = "CmdlineEnter",
    -- show match index (e.g. [2/7]) next to search results
    keys = {
      { "n", [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], desc = "Next match" },
      { "N", [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], desc = "Prev match" },
      { "*", [[*<Cmd>lua require('hlslens').start()<CR>]], desc = "Search word forward" },
      { "#", [[#<Cmd>lua require('hlslens').start()<CR>]], desc = "Search word backward" },
      { "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], desc = "Search partial word forward" },
      { "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], desc = "Search partial word backward" },
    },
  },
  {
    -- color matching brackets by nesting level (treesitter based)
    "HiPhish/rainbow-delimiters.nvim",
    event = "User FilePost",
    config = function()
      -- theme colors from the base46 "rainbowdelimiters" integration (enabled in chadrc)
      dofile(vim.g.base46_cache .. "rainbowdelimiters")
    end,
  },
  {
    -- save a session per directory on exit; restore with "s" on the snacks dashboard
    "folke/persistence.nvim",
    event = "BufReadPre", -- only save when a file was opened (dashboard-only runs don't overwrite)
    opts = {},
  },
  {
    -- centered cmdline (floating window) on top of Neovim's native ui2
    "rachartier/tiny-cmdline.nvim",
    event = "VeryLazy", -- NvChad defaults to lazy = true, so it needs a trigger
    init = function()
      -- must run before the plugin loads (init runs at startup, VeryLazy comes later)
      require("vim._core.ui2").enable {}
      vim.o.cmdheight = 0
    end,
    opts = {},
  },
}
