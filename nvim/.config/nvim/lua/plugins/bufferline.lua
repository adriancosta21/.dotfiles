return {
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        -- Numbers on buffers
        numbers = "ordinal",

        mouse = "left", -- Allow mouse left click
        move_wraps_at_ends = true,
        separator_style = "thin",

        -- Groups
        groups = {
          items = {
            {
              name = "Frontend",
              matcher = function(buf)
                local path = buf.path:lower()

                return path:match("/src/")
                  or path:match("/server/")
                  or path:match("/api/")
                  or path:match("/routes/")
                  or path:match("/controllers/")
                  or path:match("/services/")
              end,
            },

            {
              name = "JavaScript",
              matcher = function(buf)
                local path = buf.path:lower()

                return path:match("%.js$")
                  or path:match("%.jsx$")
                  or path:match("%.mjs$")
                  or path:match("%.ts$")
                  or path:match("%.tsx$")
              end,
            },
            {
              name = "HTML",
              matcher = function(buf)
                local path = buf.path:lower()

                return path:match("%.html$") or path:match("%.htm$")
              end,
            },

            {
              name = "CSS",
              matcher = function(buf)
                local path = buf.path:lower()

                return path:match("%.css$") or path:match("%.scss$") or path:match("%.sass$") or path:match("%.less$")
              end,
            },
            {
              name = "Lua",
              matcher = function(buf)
                local path = buf.path:lower()

                return path:match("%.lua$")
              end,
            },
            {
              name = "Python",
              matcher = function(buf)
                return buf.path:lower():match("%.py$")
              end,
            },

            {
              name = "Java",
              matcher = function(buf)
                return buf.path:lower():match("%.java$")
              end,
            },

            {
              name = "Go",
              matcher = function(buf)
                return buf.path:lower():match("%.go$")
              end,
            },

            {
              name = "Rust",
              matcher = function(buf)
                return buf.path:lower():match("%.rs$")
              end,
            },

            {
              name = "Ruby",
              matcher = function(buf)
                return buf.path:lower():match("%.rb$")
              end,
            },

            {
              name = "C/C++",
              matcher = function(buf)
                local path = buf.path:lower()

                return path:match("%.c$") or path:match("%.cpp$") or path:match("%.h$") or path:match("%.hpp$")
              end,
            },

            {
              name = "Markdown",
              matcher = function(buf)
                return buf.path:lower():match("%.md$")
              end,
            },

            {
              name = "Config",
              matcher = function(buf)
                local path = buf.path:lower()

                return path:match("%.json$")
                  or path:match("%.yaml$")
                  or path:match("%.conf$")
                  or path:match("%.yml$")
                  or path:match("%.toml$")
                  or path:match("%.xml$")
                  or path:match("%.kdl$")
                  or path:match("%.env$")
              end,
            },
          },
        },
      },
    },

    keys = {
      -- Picking
      {
        "<leader>bj",
        "<cmd>BufferLinePick<cr>",
        desc = "Pick Buffer",
      },

      -- Pinning
      {
        "<leader>bp",
        "<cmd>BufferLineTogglePin<cr>",
        desc = "Toggle Pin",
      },

      -- Reordering
      -- Move buffer left
      {
        "<leader>b[",
        "<cmd>BufferLineMovePrev<cr>",
        desc = "Move buffer left",
      },
      {
        "<C-[>",
        "<cmd>BufferLineMovePrev<cr>",
        desc = "Move buffer left",
      },
      -- Move buffer right
      {
        "<C-]>",
        "<cmd>BufferLineMoveNext<cr>",
        desc = "Move buffer right",
      },
      {
        "<leader>b]",
        "<cmd>BufferLineMoveNext<cr>",
        desc = "Move buffer right",
      },
    },
  },
}
