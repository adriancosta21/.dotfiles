return {
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      scope = { enabled = true }, -- ii / ai text objects, [i / ]i to jump between scopes
      indent = { enabled = true }, -- indent line highlight
      dashboard = { enabled = true },
      words = { enabled = true },
      git = { enabled = true },
      bigfile = { enabled = true }, -- disable heavy features (treesitter, LSP...) on huge files
      notifier = { enabled = true }, -- plugin notifications (vim.notify) as popups instead of cmdline messages
      -- file explorer (replaces nvim-tree); also opens when editing a directory (replace_netrw)
      -- its rename already goes through Snacks.rename, so the LSP updates imports
      explorer = { enabled = true },
      picker = {
        sources = {
          explorer = {
            hidden = true, -- show dotfiles
            layout = { layout = { position = "right" } },
            -- remember the H (hidden) / I (ignored) toggles for the next open in current session:
            on_close = function(picker)
              local cfg = Snacks.config.picker.sources.explorer
              cfg.hidden, cfg.ignored = picker.opts.hidden, picker.opts.ignored
            end,
          },
        },
      },
    },
    keys = {
      -- rename the current file and let the LSP update imports
      { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename file" },
    },
  },
}
