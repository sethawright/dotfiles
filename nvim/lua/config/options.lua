-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.laststatus = 1
vim.opt.clipboard = "unnamedplus"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.guifont = "SFMono Nerd Font:h12"
vim.opt.cursorline = false
vim.g.snacks_animate = false
-- vim.g.lazyvim_mini_snippets_in_completion = false
vim.filetype.add({
  extension = {
    ["http"] = "http",
  },
})
