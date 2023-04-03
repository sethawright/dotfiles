return {
  {
    "VonHeikemen/lsp-zero.nvim",
    lazy = true,
    event = "BufReadPre",
    config = function()
      local lsp = require("lsp-zero")
      lsp.preset("recommended")
      lsp.ensure_installed({
        "tsserver",
        "eslint",
      })
      lsp.nvim_workspace()
      lsp.setup()
    end,
    dependencies = {
      "nvim-lspconfig",
      "hrsh7th/nvim-cmp",
      "mason.nvim",
      "mason-lspconfig.nvim",
      "nvim-cmp",
      "cmp-nvim-lsp",
      "cmp_luasnip",
      "cmp-buffer",
      "cmp-path",
      "cmp-cmdline",
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    dependencies = { "mason.nvim" },
    opts = function()
      local nls = require("null-ls")
      return {
        sources = {
          nls.builtins.formatting.stylua,
          nls.builtins.diagnostics.flake8,
        },
      }
    end,
  },
  { 'neovim/nvim-lspconfig', lazy = true },
  { "williamboman/mason-lspconfig.nvim", lazy = true },
  { "williamboman/mason.nvim", lazy = true },
  { "hrsh7th/nvim-cmp", lazy = true },
  { "hrsh7th/cmp-nvim-lsp", lazy = true },
  { "hrsh7th/cmp-buffer", lazy = true },
  { "hrsh7th/cmp-path", lazy = true },
  { "hrsh7th/cmp-cmdline", lazy = true },
  { "saadparwaiz1/cmp_luasnip", lazy = true },
  { "L3MON4D3/LuaSnip", lazy = true },
  { "rafamadriz/friendly-snippets", lazy = true },
}
