return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>um", "<cmd>RenderMarkdown toggle<cr>", ft = "markdown", desc = "Toggle Markdown Render" },
    },
    opts = {
      pipe_table = { preset = "round" },
      code = { sign = false, width = "block", right_pad = 1 },
      heading = { sign = false },
    },
  },
}
