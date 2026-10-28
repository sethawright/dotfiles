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

-- Over SSH, `defaults read` and dark-notify report the appearance of the
-- *remote* Mac, not the one whose terminal we're drawing into. Neovim's
-- built-in OSC 11 query reaches the real terminal, so follow 'background'
-- (which that query sets) instead of asking macOS.
local over_ssh = vim.env.SSH_CONNECTION ~= nil

local function is_dark_mode()
  local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
  if handle then
    local result = handle:read("*a")
    handle:close()
    return result:match("Dark") ~= nil
  end
  return false -- Default to light mode
end

return {
  {
    "cormacrelf/dark-notify",
    enabled = not over_ssh,
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
      local dark_scheme, light_scheme = get_ghostty_theme()

      if over_ssh then
        -- Neovim sends an OSC 11 query at startup and waits briefly for the
        -- reply, so 'background' usually already matches the terminal here.
        opts.colorscheme = vim.o.background == "light" and light_scheme or dark_scheme

        local group = vim.api.nvim_create_augroup("ssh_background_colorscheme", { clear = true })

        -- Catch a reply that arrives after startup (slow link), and replies
        -- to the re-queries sent on focus below.
        vim.api.nvim_create_autocmd("TermResponse", {
          group = group,
          nested = true,
          callback = function(ev)
            local seq = type(ev.data) == "table" and ev.data.sequence or ev.data
            if type(seq) ~= "string" then
              return
            end
            local r, g, b = seq:match("^\027%]11;rgba?:(%x+)/(%x+)/(%x+)")
            if not r then
              return
            end
            local function norm(hex)
              return tonumber(hex, 16) / (16 ^ #hex - 1)
            end
            local luminance = 0.299 * norm(r) + 0.587 * norm(g) + 0.114 * norm(b)
            local target = luminance < 0.5 and dark_scheme or light_scheme
            if vim.g.colors_name == target then
              return
            end
            local ok, err = pcall(vim.cmd.colorscheme, target)
            if not ok then
              vim.notify("darkmode: " .. tostring(err), vim.log.levels.WARN)
              return
            end
            vim.api.nvim_set_hl(0, "StatusLine", { bg = "None" })
          end,
        })

        -- Ask the terminal again when we regain focus, so an appearance
        -- switch on the client Mac while nvim is open gets picked up.
        vim.api.nvim_create_autocmd("FocusGained", {
          group = group,
          callback = function()
            pcall(vim.api.nvim_ui_send, "\027]11;?\007")
          end,
        })
        return
      end

      if is_dark_mode() then
        opts.colorscheme = dark_scheme
      else
        opts.colorscheme = light_scheme
      end
    end,
  },
}
