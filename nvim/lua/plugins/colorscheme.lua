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
        -- vim.cmd("colorscheme github_dark")
        -- vim.opt.background = "dark"
        -- vim.cmd("colorscheme nightfox")
        -- vim.api.nvim_set_hl(0, "SnacksIndentScope", { link = "DiagnosticSignInfo" })
        -- vim.api.nvim_set_hl(0, "SnacksIndent", { link = "IndentBlanklineChar" })
        vim.api.nvim_set_hl(0, "StatusLine", { bg = "None" })
      end,
      set_light_mode = function()
        -- vim.cmd("colorscheme tokyonight-day")
        -- vim.cmd("colorscheme rose-pine-dawn")
        -- vim.cmd("colorscheme github_light")
        -- vim.opt.background = "light"
        -- vim.cmd("colorscheme dayfox")
        -- vim.api.nvim_set_hl(0, "SnacksIndentScope", { link = "DiagnosticSignInfo" })
        -- vim.api.nvim_set_hl(0, "SnacksIndent", { fg = "#f4f4f4" })
        vim.api.nvim_set_hl(0, "StatusLine", { bg = "None" })
      end,
    },
  },

  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      local function is_dark_mode()
        local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
        if handle then
          local result = handle:read("*a")
          handle:close()
          return result:match("Dark") ~= nil
        end
        return false -- Default to light mode if command fails
      end

      -- Example usage
      if is_dark_mode() then
        opts.colorscheme = "catppuccin-macchiato"
      else
        opts.colorscheme = "catppuccin-latte"
      end

      -- opts.colorscheme = "github_dark"
      -- opts.colorscheme = "nightfox"
      -- opts.colorscheme = "rose-pine"
    end,
  },
}
