return {
  {
    "jakewvincent/mkdnflow.nvim",
    config = function()
      require("mkdnflow").setup({
        wrap = true,
        mappings = {
          MkdnCreateLinkFromClipboard = { { "n", "v" }, "<leader>l" },
          MkdnFoldSection = false,
          MkdnUnfoldSection = false,
        },
      })
    end,
  },
}
