return {
  { "rose-pine/neovim", name = "rose-pine" },
  { "projekt0n/github-nvim-theme" },
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {},
  -- },
  -- { "catppuccin/nvim", name = "catppuccin" },

  -- Configure LazyVim to load gruvbox
  {
    "f-person/auto-dark-mode.nvim",
    opts = {
      update_interval = 5000,
      set_dark_mode = function()
        -- vim.cmd("colorscheme rose-pine-main")
        vim.api.nvim_set_option("background", "dark")
        vim.cmd("colorscheme github_dark")
      end,
      set_light_mode = function()
        -- vim.cmd("colorscheme rose-pine-dawn")
        vim.api.nvim_set_option("background", "light")
        vim.cmd("colorscheme github_light")
      end,
    },
  },

  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      -- opts.colorscheme = "tokyonight-night"
      -- opts.colorscheme = "rose-pine"
      opts.colorscheme = "github_light"
    end,
  },
}
