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
  },
}
