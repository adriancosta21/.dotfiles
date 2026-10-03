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
    },
    keys = {
      -- rename the current file and let the LSP update imports
      { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename file" },
    },
    init = function()
      -- rename module: notify the LSP when a file is renamed in nvim-tree (updates imports)
      local prev = { new_name = "", old_name = "" } -- nvim-tree may fire the same event twice
      vim.api.nvim_create_autocmd("User", {
        pattern = "NvimTreeSetup",
        callback = function()
          local events = require("nvim-tree.api").events
          events.subscribe(events.Event.NodeRenamed, function(data)
            if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
              prev = data
              Snacks.rename.on_rename_file(data.old_name, data.new_name)
            end
          end)
        end,
      })
    end,
  },
}
