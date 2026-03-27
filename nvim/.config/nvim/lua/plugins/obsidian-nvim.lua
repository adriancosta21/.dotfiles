return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  opts = function()
    local workspaces = {}
    local vaults_path = vim.fn.expand("~/vaults/")
    local folders = vim.fn.glob(vaults_path .. "*/", false, true)

    for _, folder in ipairs(folders) do
      local name = vim.fn.fnamemodify(folder, ":h:t")
      table.insert(workspaces, {
        name = name,
        path = folder,
      })
    end

    return {
      workspaces = workspaces,
      -- see below for full list of options 👇
    }
  end,
}
