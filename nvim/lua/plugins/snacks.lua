local function get_main_branch()
  local handle = io.popen("git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'")
  local default_branch = handle:read("*l")
  handle:close()
  return default_branch
end

local function get_modified_to_main()
  local branch = get_main_branch()
  local files = {}
  for file in io.popen("git diff --name-only " .. branch .. "...HEAD"):lines() do
    table.insert(files, file)
  end
  return files
end

return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader>gm",
      function()
        Snacks.picker.pick({
          preview = "preview",
          finder = function()
            local items = {}
            local files = get_modified_to_main()
            local git = require("snacks.picker.source.git")
            for i, item in ipairs(files) do
              local preview_text = ""
              local handle = io.popen("git diff " .. get_main_branch() .. " -- " .. item)
              if handle then
                preview_text = handle:read("*a")
                handle:close()
              end

              local handle = io.popen("git diff " .. get_main_branch() .. " -- " .. item)
              if handle then
                preview_text = handle:read("*a")
                handle:close()
              end

              table.insert(items, {
                idx = i,
                file = item,
                preview = { text = preview_text, ft = "git", loc = false },
              })
            end
            return items
          end,
          layout = {
            layout = {
              box = "horizontal",
              width = 0.9,
              height = 0.8,
              {
                box = "vertical",
                width = 0.4,
                border = "rounded",
                title = "Files changed from origin/" .. get_main_branch(),
                { win = "input", height = 1, border = "bottom" },
                { win = "list", border = "none" },
              },
              {
                win = "preview",
                width = 0.6,
                border = "rounded",
                title = "Diff Preview",
              },
            },
          },
        })
      end,
      desc = "Git Files (diff Main Branch)",
    },
    {
      "<leader>p",
      function()
        Snacks.picker.files()
      end,
      desc = "Files",
    },
    {
      "<leader>;",
      function()
        Snacks.picker.lines()
      end,
      desc = "Lines",
    },
    {
      "<leader>o",
      function()
        Snacks.picker.lsp_symbols({ filter = LazyVim.config.kind_filter })
      end,
      desc = "Symbols",
    },
    {
      "<leader>e",
      false,
    },
  },
}
