return {
  -- add gruvbox
  {
    "projekt0n/github-nvim-theme",
    tag = "v0.0.7",
    config = function()
      require("github-theme").setup({})
      require("util").setColorScheme()
    end,
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      opts.colorscheme = require("util").getScheme()
    end,
  },
}
