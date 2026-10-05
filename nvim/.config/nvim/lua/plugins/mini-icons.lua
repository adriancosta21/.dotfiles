-- File/folder icons for the whole UI (snacks explorer, buffer bar, Telescope...).
-- mini.icons already knows src, lib, node_modules, test(s), docs, build, .github, .config...;
-- below are extra web-dev folders, VS Code style (glyphs reused from mini.icons' own set)
return {
  {
    "nvim-mini/mini.icons",
    lazy = true,
    init = function()
      -- anything that requires nvim-web-devicons gets mini.icons instead (same icons everywhere)
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
    opts = {
      directory = {
        [".vscode"] = { glyph = "󰉋", hl = "MiniIconsBlue" },
        api = { glyph = "󰉋", hl = "MiniIconsOrange" },
        assets = { glyph = "󰉏", hl = "MiniIconsYellow" },
        components = { glyph = "󰉋", hl = "MiniIconsBlue" }, -- Azure is the default folder color
        config = { glyph = "󱁿", hl = "MiniIconsCyan" },
        dist = { glyph = "󱧼", hl = "MiniIconsGrey" },
        hooks = { glyph = "󰉋", hl = "MiniIconsPurple" },
        middlewares = { glyph = "󰉋", hl = "MiniIconsOrange" },
        models = { glyph = "󰉋", hl = "MiniIconsRed" },
        pages = { glyph = "󰉋", hl = "MiniIconsCyan" },
        public = { glyph = "󱧰", hl = "MiniIconsAzure" },
        routes = { glyph = "󰉋", hl = "MiniIconsGreen" },
        styles = { glyph = "󰉋", hl = "MiniIconsPurple" },
        types = { glyph = "󰉋", hl = "MiniIconsBlue" },
        utils = { glyph = "󰉋", hl = "MiniIconsYellow" },
      },
    },
  },
}
