return {
  "blink.cmp",
  opts = {
    keymap = {
      preset = "none", -- desabilita todos os keybinds padrão

      -- Aceita sugestão apenas com <Tab> (supertab) ou <C-f>
      ["<Tab>"] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.accept()
          else
            return cmp.select_and_accept()
          end
        end,
        "snippet_forward",
        "fallback",
      },
      ["<C-f>"] = { "accept", "fallback" },

      ["<C-n>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },

      -- Desabilita Enter
      ["<CR>"] = {},
      -- Outros exemplos de navegação/documentação (opcional)
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    },
  },
}
