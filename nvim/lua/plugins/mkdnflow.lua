return {
  {
    "jakewvincent/mkdnflow.nvim",
    config = function()
      require("mkdnflow").setup({
        wrap = true,
        -- Resolve relative links from the current file, like GitHub does.
        path_resolution = { primary = "current" },
        mappings = {
          MkdnCreateLinkFromClipboard = { { "n", "v" }, "<leader>l" },
          MkdnFoldSection = false,
          MkdnUnfoldSection = false,
        },
      })
    end,
  },
}
