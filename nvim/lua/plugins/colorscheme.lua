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
        -- vim.cmd("colorscheme tokyonight-night")
        -- vim.cmd("colorscheme rose-pine-main")
        vim.cmd("colorscheme github_dark_tritanopia")
        vim.opt.background = "dark"
        vim.api.nvim_set_hl(0, "StatusLine", {
          bg = "None",
          link = "Normal",
        })
      end,
      set_light_mode = function()
        -- vim.cmd("colorscheme tokyonight-day")
        -- vim.cmd("colorscheme rose-pine-dawn")
        vim.cmd("colorscheme github_light")
        vim.opt.background = "light"
        vim.api.nvim_set_hl(0, "StatusLine", {
          bg = "None",
          link = "Normal",
        })
      end,
    },
  },

  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      opts.colorscheme = "github_dark_tritanopia"
      -- opts.colorscheme = "rose-pine"
    end,
  },
}
