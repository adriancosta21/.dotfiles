return {
  {
    "obsidian-nvim/obsidian.nvim", -- switching from the main epwalsh/obsidian.nvim
    version = "*",
    lazy = true,
    ft = "markdown",
    keys = {
      { "<leader>oj", "<cmd>Obsidian today<cr>", desc = "Today's note" },
      { "<leader>oy", "<cmd>Obsidian yesterday<cr>", desc = "Yesterday's note" },
      { "<leader>ot", "<cmd>Obsidian tomorrow<cr>", desc = "Tomorrow's note" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = function()
      local candidates = {
        "~/Vaults/",
        "~/vaults",
        "~/Documents/vaults",
        "~/Documents/Vaults/",
      }
      local vaults_path
      for _, candidate in ipairs(candidates) do
        local expanded = vim.fn.expand(candidate)
        if vim.fn.isdirectory(expanded) == 1 then
          vaults_path = expanded
          break
        end
      end
      local workspaces = {}
      if vaults_path then
        for _, folder in ipairs(vim.fn.glob(vaults_path .. "*/", false, true)) do
          table.insert(workspaces, {
            name = vim.fn.fnamemodify(folder, ":t"),
            path = folder,
          })
        end
      end
      if #workspaces == 0 then
        vim.notify("obsidian.nvim: no vault folders found in " .. table.concat(candidates, ", "), vim.log.levels.WARN)
        workspaces = { { name = "vaults", path = vim.fn.expand(candidates[1]) } }
      end
      return {
        workspaces = workspaces,
        daily_notes = {
          folder = "dailynotes",
        },
      }
    end,
  },
}
