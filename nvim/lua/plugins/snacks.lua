return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    ---@type table<string, snacks.win.Config>
    styles = {
      zen = {
        width = 0.8,
        height = 0.8,
      },
    },
    picker = {
      layout = {
        layout = {
          box = "horizontal",
          fullscreen = true,
          {
            box = "vertical",
            border = "rounded",
            title = "{title} {live} {flags}",
            { win = "input", height = 1, border = "bottom" },
            { win = "list", border = "none" },
          },
          { win = "preview", title = "{preview}", border = "rounded", width = 0.6 },
        },
      },
      win = {
        input = {
          keys = {
            ["<c-u>"] = {
              "preview_scroll_up",
              mode = { "n", "i" },
            },
            ["<c-d>"] = {
              "preview_scroll_down",
              mode = { "n", "i" },
            },
            ["<c-l>"] = {
              "focus_preview",
              mode = { "n", "i" },
            },
          },
        },
        list = {
          keys = {
            ["<c-l>"] = "focus_preview",
          },
        },
        preview = {
          keys = {
            ["<c-h>"] = "focus_list",
          },
        },
      },
    },
  },
  keys = {
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
    {
      "<leader>gs",
      function()
        Snacks.picker.git_status()
      end,
      desc = "Git Status",
    },
    {
      "<leader>gd",
      function()
        Snacks.picker.git_diff()
      end,
      desc = "Git Diff (HEAD)",
    },
    {
      "<leader>gm",
      function()
        local base = vim.fn.system("git rev-parse --verify main 2>/dev/null"):find("^%x") and "main" or "master"
        Snacks.picker.git_diff({ base = base, group = true })
      end,
      desc = "Git Diff (base branch)",
    },
    {
      "<leader>gc",
      function()
        local base = vim.fn.system("git rev-parse --verify main 2>/dev/null"):find("^%x") and "main" or "master"
        Snacks.picker.git_diff({ base = base, group = false })
      end,
      desc = "Git Diff Chunks (base branch)",
    },
    {
      "<leader>gl",
      function()
        Snacks.picker.git_log()
      end,
      desc = "Git Log",
    },
    {
      "<leader>gb",
      function()
        Snacks.picker.git_branches()
      end,
      desc = "Git Branches",
    },
    {
      "<leader>gh",
      function()
        Snacks.picker.git_log_line()
      end,
      desc = "Git History (line)",
    },
  },
}
