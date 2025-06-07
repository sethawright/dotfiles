local function get_ghostty_theme()
  local filepath = os.getenv("HOME") .. "/.config/ghostty/config"
  local file = io.open(filepath, "r")
  if not file then
    return "github_dark", "github_light" -- default fallback
  end

  for line in file:lines() do
    local dark, light = line:match("^theme%s*=%s*dark:([^,]+),light:([^\n]+)")
    if dark and light then
      if dark:match("Github") or light:match("Github") then
        local dark_scheme = "github_dark"
        local light_scheme = "github_light"
        file:close()
        return dark_scheme, light_scheme
      elseif dark:match("catppuccin") or light:match("catppuccin") then
        local dark_scheme = "catppuccin-macchiato"
        local light_scheme = "catppuccin-latte"
        file:close()
        return dark_scheme, light_scheme
      elseif dark:match("nightfox") or light:match("dayfox") then
        local dark_scheme = "nightfox"
        local light_scheme = "dayfox"
        file:close()
        return dark_scheme, light_scheme
      end
    end
  end

  file:close()
  return "github_dark", "github_light" -- fallback if not found
end

return {
  -- Configure LazyVim to load gruvbox
  {
    "cormacrelf/dark-notify",
    config = function()
      local dark, light = get_ghostty_theme()

      require("dark_notify").run({
        schemes = {
          dark = dark,
          light = light,
        },
        onchange = function()
          vim.api.nvim_set_hl(0, "StatusLine", { bg = "None" })
          -- Optional: additional highlight tweaking
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
        return false -- Default to light mode
      end

      local dark_scheme, light_scheme = get_ghostty_theme()

      if is_dark_mode() then
        opts.colorscheme = dark_scheme
      else
        opts.colorscheme = light_scheme
      end
    end,
  },
}
