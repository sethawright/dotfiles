return {
  -- add github
  {
    "projekt0n/github-nvim-theme",
    config = function()
      require("github-theme").setup({})
      require("util").setColorScheme()
    end,
  },

  { "catppuccin/nvim", name = "catppuccin" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      opts.colorscheme = require("util").getScheme()
    end,
  },
}
