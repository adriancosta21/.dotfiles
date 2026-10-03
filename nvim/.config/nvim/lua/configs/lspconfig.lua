require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls" }
vim.lsp.enable(servers)

-- Signature help hardcodes "(<C-s> to cycle)" in its title; rewrite it to the keys
-- set in mappings.lua before the float is drawn
local open_floating_preview = vim.lsp.util.open_floating_preview
vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
  local function fix(s)
    return (s:gsub("<C%-s> to cycle", "<C-n>/<C-p> to cycle"))
  end
  if opts and type(opts.title) == "string" then
    opts.title = fix(opts.title)
  end
  if contents[1] then
    contents[1] = fix(contents[1])
  end
  return open_floating_preview(contents, syntax, opts, ...)
end
