return {
  { "tmillr/github-nvim-theme", branch = "fix-298" },
  -- { "projekt0n/github-nvim-theme" },
  { "catppuccin/nvim", name = "catppuccin" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      opts.colorscheme = require("util").getScheme()
    end,
  },
}
