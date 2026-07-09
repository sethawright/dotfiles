return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      denols = {
        enabled = true,
      },
      oxlint = {},
      oxfmt = {},
      graphql = {},
    },
  },
}
