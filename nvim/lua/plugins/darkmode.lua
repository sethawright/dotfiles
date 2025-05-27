return {
  -- Configure LazyVim to load gruvbox
  {
    "cormacrelf/dark-notify",
    config = function()
      require("dark_notify").run({
        schemes = {
          dark = "github_dark",
          light = "github_light",
        },
        onchange = function()
          vim.api.nvim_set_hl(0, "StatusLine", { bg = "None" })

          -- catppuccin
          -- vim.api.nvim_set_hl(0, "SnacksIndentScope", { link = "IblScope" })
          -- vim.api.nvim_set_hl(0, "SnacksIndent", { link = "IblIndent" })
        end,
      })
    end,
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
