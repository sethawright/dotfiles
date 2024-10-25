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
        vim.cmd("colorscheme tokyonight")
        -- vim.cmd("colorscheme rose-pine-main")
        -- vim.cmd("colorscheme github_dark")
        -- vim.opt.background = "dark"
      end,
      set_light_mode = function()
        vim.cmd("colorscheme tokyonight-day")
        -- vim.cmd("colorscheme rose-pine-dawn")
        -- vim.cmd("colorscheme github_light")
        -- vim.opt.background = "light"
      end,
    },
  },

  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      opts.colorscheme = "github_dark"
      -- opts.colorscheme = "rose-pine"
    end,
  },
}
