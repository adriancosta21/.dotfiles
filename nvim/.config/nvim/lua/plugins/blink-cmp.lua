return {
  "blink.cmp",
  dependencies = {
    "Kaiser-Yang/blink-cmp-dictionary",
  },
  opts = {
    completion = {
      list = {
        selection = {
          preselect = false,
          auto_insert = false,
        },
      },
    },
    sources = {
      per_filetype = {
        markdown = { "lsp", "path", "snippets", "buffer", "dictionary" },
      },
      providers = {
        dictionary = {
          module = "blink-cmp-dictionary",
          name = "Dict",
          min_keyword_length = 3,
          max_items = 8,
          opts = {
            dictionary_files = { "/usr/share/dict/words" }, -- can be installed with the words package
          },
        },
      },
    },
    keymap = {
      preset = "none",
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
      ["<CR>"] = {},
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    },
  },
}
