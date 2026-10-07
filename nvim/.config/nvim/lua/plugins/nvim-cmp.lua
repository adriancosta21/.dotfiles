-- Setup minor mapping changes and styling
return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require "cmp"
    local luasnip = require "luasnip"

    opts.matching = { disallow_partial_fuzzy_matching = false } -- match completions anywhere in the word, not only at the start ("blue" also matches "lightblue")
    -- Enter only inserts a newline
    opts.mapping["<CR>"] = nil

    -- Tab: accept suggestion (first one if none selected), otherwise jump in snippet
    opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm { select = true }
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" })

    -- Ctrl+f: accept suggestion
    opts.mapping["<C-f>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm { select = true }
      else
        fallback()
      end
    end, { "i", "s" })

    -- Cycle the open signature help window without leaving insert mode, by calling the
    -- "<Plug>(nvim.lsp.ctrl-s)" callback that Neovim sets on the float's buffer.
    -- Returns false when no signature window is open.
    local function cycle_signature(step)
      for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        if vim.w[win]["textDocument/signatureHelp"] then
          for _, m in ipairs(vim.api.nvim_buf_get_keymap(vim.api.nvim_win_get_buf(win), "n")) do
            if m.lhs == "<Plug>(nvim.lsp.ctrl-s)" then
              -- builtin only cycles forward: going back one = forward (total - 1) times
              local title = vim.api.nvim_win_get_config(win).title
              local text = type(title) == "table" and title[1] and title[1][1] or ""
              local total = tonumber(text:match "%(%d+/(%d+)%)") or 1
              for _ = 1, step > 0 and 1 or total - 1 do
                m.callback()
              end
              return true
            end
          end
        end
      end
      return false
    end

    -- Ctrl+n / Ctrl+p: navigate the menu when open, otherwise cycle signature overloads
    opts.mapping["<C-n>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif not cycle_signature(1) then
        fallback()
      end
    end, { "i" })

    opts.mapping["<C-p>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif not cycle_signature(-1) then
        fallback()
      end
    end, { "i" })
  end,
}
