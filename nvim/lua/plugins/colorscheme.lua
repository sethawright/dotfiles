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
          SnacksIndentScope = { link = "IndentBlanklineContextChar" },
          SnacksIndent = { link = "IndentBlanklineChar" },
          LineNr = { link = "IndentBlanklineChar" },
          Type = { fg = "palette.magenta" },
          ["@type"] = { fg = "palette.magenta" },
          ["@type.builtin"] = { fg = "palette.blue" },
          ["@variable"] = { fg = "palette.blue" },
          ["@variable.parameter"] = { fg = "palette.orange" },
          ["@punctuation.bracket"] = { fg = "palette.blue" },
        },
        github_light = {
          ["@variable.member"] = { fg = "palette.black" },
        },
        github_dark = {
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
  { "catppuccin/nvim", name = "catppuccin" },
  { "EdenEast/nightfox.nvim", name = "nightfox" },

  -- Configure LazyVim to load gruvbox
  {
    "f-person/auto-dark-mode.nvim",
    opts = {
      set_dark_mode = function()
        -- vim.cmd("colorscheme tokyonight-night")
        -- vim.cmd("colorscheme rose-pine-main")

        -- github
        vim.cmd("colorscheme github_dark")

        -- vim.cmd("colorscheme nightfox")

        -- catppuccin
        -- vim.cmd("colorscheme catppuccin-macchiato")
        -- vim.api.nvim_set_hl(0, "SnacksIndentScope", { link = "IblScope" })
        -- vim.api.nvim_set_hl(0, "SnacksIndent", { link = "IblIndent" })

        vim.api.nvim_set_hl(0, "StatusLine", { bg = "None" })
      end,
      set_light_mode = function()
        -- vim.cmd("colorscheme tokyonight-day")
        -- vim.cmd("colorscheme rose-pine-dawn")

        -- github
        vim.cmd("colorscheme github_light")

        -- vim.cmd("colorscheme dayfox")

        -- catppuccin
        -- vim.cmd("colorscheme catppuccin-latte")
        -- vim.api.nvim_set_hl(0, "SnacksIndentScope", { link = "IblScope" })
        -- vim.api.nvim_set_hl(0, "SnacksIndent", { link = "IblIndent" })

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
        opts.colorscheme = "github_dark"
        -- opts.colorscheme = "catppuccin-macchiato"
        -- opts.colorscheme = "nightfox"
        -- opts.colorscheme = "rose-pine"
      else
        opts.colorscheme = "github_light"
        -- opts.colorscheme = "catppuccin-latte"
        -- opts.colorscheme = "dawnfox"
        -- opts.colorscheme = "rose-pine-dawn"
      end
    end,
  },
}
