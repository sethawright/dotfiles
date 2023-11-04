return {
  "echasnovski/mini.files",
  opts = {
    windows = {
      preview = true,
    },
  },
  keys = {
    {
      "<leader>b",
      function()
        require("mini.files").open(vim.loop.cwd(), true)
      end,
      desc = "Open mini.files (cwd)",
    },
  },
}
