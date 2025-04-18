return {
  { "rose-pine/neovim", name = "rose-pine" },
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    opts = {
      options = {
        transparent = true,
      },
    },
  },
  { "datsfilipe/min-theme.nvim" },
  { "navarasu/onedark.nvim" },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  { "catppuccin/nvim", name = "catppuccin" },
  { "EdenEast/nightfox.nvim", name = "nightfox" },

  -- Configure LazyVim to load gruvbox
  {
    "f-person/auto-dark-mode.nvim",
    opts = {
      update_interval = 5000,
      set_dark_mode = function()
        -- vim.cmd("colorscheme tokyonight-night")
        -- vim.cmd("colorscheme rose-pine-main")
        -- vim.cmd("colorscheme github_dark")
        vim.cmd("colorscheme github_dark")
        -- vim.opt.background = "dark"
        -- vim.cmd("colorscheme nightfox")
        vim.api.nvim_set_hl(0, "SnacksIndentScope", { link = "DiagnosticSignInfo" })
        vim.api.nvim_set_hl(0, "SnacksIndent", { link = "IndentBlanklineChar" })
      end,
      set_light_mode = function()
        -- vim.cmd("colorscheme tokyonight-day")
        -- vim.cmd("colorscheme rose-pine-dawn")
        vim.cmd("colorscheme github_light")
        -- vim.opt.background = "light"
        -- vim.cmd("colorscheme dayfox")
        vim.api.nvim_set_hl(0, "SnacksIndentScope", { link = "DiagnosticSignInfo" })
        vim.api.nvim_set_hl(0, "SnacksIndent", { fg = "#f4f4f4" })
      end,
    },
  },

  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      opts.colorscheme = "github_dark"
      -- opts.colorscheme = "nightfox"
      -- opts.colorscheme = "rose-pine"
    end,
  },
}
