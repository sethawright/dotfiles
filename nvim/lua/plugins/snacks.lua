return {
  "folke/snacks.nvim",
  keys = {
    {
      "<C-space>",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Buffers",
    },
    {
      "<leader>p",
      function()
        Snacks.picker.files()
      end,
      desc = "Files",
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
