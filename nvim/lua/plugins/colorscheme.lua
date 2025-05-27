return {
  { "rose-pine/neovim", name = "rose-pine" },
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    opts = {
      options = {
        transparent = true,
        styles = {
          comments = "italic",
        },
      },
      palettes = {
        github_light = {
          orange = "#e36209",
        },
        github_dark = {
          orange = "#ffab70",
        },
      },
      groups = {
        all = {
          StatusLine = { bg = "None" },
          SnacksIndentScope = { link = "IndentBlanklineContextChar" },
          SnacksIndent = { link = "IndentBlanklineChar" },
          LineNr = { link = "IndentBlanklineChar" },
          Type = { fg = "palette.magenta" },
          ["@type"] = { fg = "palette.magenta" },
          ["@type.builtin"] = { fg = "palette.blue" },
          ["@variable.parameter"] = { fg = "palette.orange" },
          ["@punctuation.bracket"] = { fg = "palette.blue" },
        },
        github_light = {
          ["@variable"] = { fg = "palette.blue" },
          ["@variable.member"] = { fg = "palette.black" },
        },
        github_dark = {
          ["@variable"] = { fg = "palette.blue.bright" },
          ["@variable.member"] = { fg = "#ffffff" },
        },
      },
    },
  },
  { "nyoom-engineering/oxocarbon.nvim" },
  { "datsfilipe/min-theme.nvim" },
  { "Mofiqul/vscode.nvim" },
  { "navarasu/onedark.nvim" },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  { "catppuccin/nvim", name = "catppuccin", opts = {
    transparent_background = true,
  } },
  { "EdenEast/nightfox.nvim", name = "nightfox" },
}
