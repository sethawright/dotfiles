-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Allow tmux to handle M-[ binding
vim.keymap.set({ "n", "i", "v", "t" }, "<M-[>", "<Nop>", { noremap = true, silent = true })
-- Allow tmux to handle M-] binding
vim.keymap.set({ "n", "i", "v", "t" }, "<M-]>", "<Nop>", { noremap = true, silent = true })
-- Allow tmux to handle M-/ binding
vim.keymap.set({ "n", "i", "v", "t" }, "<M-/>", "<Nop>", { noremap = true, silent = true })

local function get_path(absolute)
  local buf = vim.api.nvim_get_current_buf()
  local file = vim.api.nvim_buf_get_name(buf)
  if file == "" then
    vim.notify("No file name for current buffer", vim.log.levels.WARN)
    return nil
  end

  if absolute then
    return file
  end

  local git = vim.system({ "git", "rev-parse", "--show-toplevel" }, { text = true }):wait()
  local root = git.code == 0 and git.stdout:gsub("%s+$", "") or vim.fn.getcwd()

  if file:sub(1, #root) == root then
    return file:sub(#root + 2)
  end
  return vim.fn.fnamemodify(file, ":~:.")
end

vim.keymap.set("n", "<leader>yp", function()
  local path = get_path(false)
  if not path then
    return
  end
  vim.fn.setreg('"', path)
  pcall(vim.fn.setreg, "+", path)
  vim.notify("Yanked: " .. path)
end, { desc = "Yank relative file path" })

vim.keymap.set("n", "<leader>yP", function()
  local path = get_path(true)
  if not path then
    return
  end
  vim.fn.setreg('"', path)
  pcall(vim.fn.setreg, "+", path)
  vim.notify("Yanked: " .. path)
end, { desc = "Yank absolute file path" })

-- Visual mode: path + line range
local function yank_with_range(absolute)
  local path = get_path(absolute)
  if not path then
    return
  end

  local start_line = vim.fn.line("v")
  local end_line = vim.fn.line(".")
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end

  local location = path .. ":" .. start_line .. "-" .. end_line
  vim.fn.setreg("+", location)
  vim.notify("Yanked: " .. location)
  vim.cmd("normal! \27")
end

vim.keymap.set("v", "<leader>ay", function()
  yank_with_range(false)
end, { desc = "Yank relative path with line range" })
vim.keymap.set("v", "<leader>aY", function()
  yank_with_range(true)
end, { desc = "Yank absolute path with line range" })

vim.keymap.set("n", "<leader>yf", "<cmd>:%y+<cr>", { silent = true, desc = "Yank Entire File" })
vim.keymap.set("n", "<leader>q", "<cmd>:q<cr>", { desc = "Quit" })

vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })

vim.keymap.set("n", "+", "<cmd>wincmd =<cr>", { silent = true })
vim.keymap.set("n", "=", "<cmd>vertical resize +10<cr>", { silent = true })
vim.keymap.set("n", "-", "<cmd>vertical resize -10<cr>", { silent = true })

vim.keymap.set("n", ",tw", "<cmd>set invwrap<CR><cmd>set wrap?<CR><cmd>set linebreak<CR>", { silent = true })
vim.keymap.set("n", ",,a", "ggVG", { desc = "Select entire file" })
vim.keymap.del("v", "<")
vim.keymap.del("v", ">")

vim.keymap.set({ "n", "v" }, "<PageUp>", "<C-u>", { silent = true })
vim.keymap.set({ "n", "v" }, "<PageDown>", "<C-d>", { silent = true })
