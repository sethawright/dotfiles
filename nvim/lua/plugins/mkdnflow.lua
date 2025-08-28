return {
  {
    "jakewvincent/mkdnflow.nvim",
    config = function()
      require("mkdnflow").setup({
        filetypes = { md = true, rmd = true, markdown = true, text = true, txt = true },
        wrap = true,
      })
    end,
  },
}
