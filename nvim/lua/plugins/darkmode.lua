local function get_ghostty_theme()
  -- Define your theme mapping here - update as needed
  local theme_map = {
    ["nightfox"] = "nightfox",
    ["dayfox"] = "dayfox",
    ["Github-Dark-Dimmed"] = "github_dark",
    ["Github-Light-Default"] = "github_light",
    ["Github Dark Dimmed"] = "github_dark",
    ["Github Light Default"] = "github_light",
    ["Catppuccin-Macchiato"] = "catppuccin-macchiato",
    ["Catppuccin-Latte"] = "catppuccin-latte",
    ["Catppuccin Macchiato"] = "catppuccin-macchiato",
    ["Catppuccin Latte"] = "catppuccin-latte",
  }

  local filepath = os.getenv("HOME") .. "/.config/ghostty/config"
  local file = io.open(filepath, "r")
  if not file then
    return "github_dark", "github_light" -- default fallback
  end

  for line in file:lines() do
    local dark, light = line:match("^theme%s*=%s*dark:([^,]+),light:([^\n]+)")
    if dark and light then
      -- Strip whitespace and get themes from map
      dark = dark:match("^%s*(.-)%s*$")
      light = light:match("^%s*(.-)%s*$")

      local dark_scheme = theme_map[dark] or dark
      local light_scheme = theme_map[light] or light

      file:close()
      return dark_scheme, light_scheme
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
