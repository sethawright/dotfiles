return {
  -- { "nvim-treesitter/playground" },
  {
    "nvim-treesitter/nvim-treesitter",
    keys = function()
      return {}
    end,
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "jsdoc",
        "glimmer",
        "graphql",
      })
      opts.incremental_selection = {
        enable = false,
      }
    end,
  },
}
