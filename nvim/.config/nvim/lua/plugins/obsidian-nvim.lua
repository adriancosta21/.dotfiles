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
        -- isdirectory() only ever returns 1 (is a directory) or 0 (is not)
        if vim.fn.isdirectory(expanded) == 1 then
          vaults_path = expanded
          break
        end
      end
      local workspaces = {}
      if vaults_path then
        for _, folder in ipairs(vim.fn.glob(vaults_path .. "*/", false, true)) do
          -- strip trailing slash so both name and path are computed correctly
          local clean_path = folder:gsub("/$", "")
          table.insert(workspaces, {
            name = vim.fn.fnamemodify(clean_path, ":t"),
            path = clean_path,
          })
        end
      end
      -- fallback so the plugin doesn't crash if no vault folders are found
      if #workspaces == 0 then
        vim.notify("obsidian.nvim: no vault folders found in " .. table.concat(candidates, ", "), vim.log.levels.WARN)
        workspaces = { { name = "vaults", path = vim.fn.expand(candidates[1]) } }
      end

      return {
        workspaces = workspaces,
        daily_notes = {
          folder = "dailynotes",
        },
        legacy_commands = false, -- Disable legacy commands to avoid unnecessary warning messages
        note_id_func = function(title)
          if title then
            return title
          end
          return require("obsidian.builtin").zettel_id(title)
        end,
        -- explicit override: always use the directory of the buffer that's currently open, regardless of which internal flow created the note
        note_path_func = function(spec)
          local current_file = vim.api.nvim_buf_get_name(0)
          local current_dir = current_file ~= "" and vim.fs.dirname(current_file) or tostring(spec.dir)
          local title = spec.title or tostring(spec.id)
          return vim.fs.joinpath(current_dir, title .. ".md")
        end,
      }
    end,
  },
}
