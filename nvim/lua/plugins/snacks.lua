return {
  "folke/snacks.nvim",
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
  },
}
