return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
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

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
