return {
  "HiPhish/rainbow-delimiters.nvim",
  event = "VeryLazy",
  main = "rainbow-delimiters.setup", -- o setup() vive nesse submódulo, não no módulo principal
  opts = {
    strategy = {
      [""] = "rainbow-delimiters.strategy.global",
    },
    query = {
      [""] = "rainbow-delimiters",
      lua = "rainbow-blocks",
    },
    highlight = {
      "RainbowDelimiterRed",
      "RainbowDelimiterYellow",
      "RainbowDelimiterBlue",
      "RainbowDelimiterOrange",
      "RainbowDelimiterGreen",
      "RainbowDelimiterViolet",
      "RainbowDelimiterCyan",
    },
  },
}
