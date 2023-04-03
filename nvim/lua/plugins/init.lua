local lsp = require("plugins.lsp")
local telescope = require("plugins.telescope").deps
local neotree = require("plugins.neotree")
local gitsigns = require("plugins.gitsigns")
local illuminate = require("plugins.illuminate")
local trouble = require("plugins.trouble")
local github = require("plugins.github")

local plugins = {
  { "nvim-lua/plenary.nvim", lazy = true },
  { "folke/lazy.nvim", tag = "stable" },
  { "tpope/vim-fugitive" },
  { "mbbill/undotree" },
  { "github/copilot.vim" },

  lsp,
  telescope,
  neotree,
  gitsigns,
  illuminate,
  trouble,
  github,
}

return plugins
