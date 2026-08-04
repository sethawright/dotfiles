local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("terraform"),
  pattern = { "terraform-vars" },
  callback = function()
    vim.cmd("set filetype=terraform")
  end,
})

-- Keep syntax/treesitter highlighting visible inside diff (added/removed/changed)
-- regions by stripping the foreground from the Diff* groups, leaving only their
-- backgrounds. Runs on every colorscheme swap so it survives dark/light toggling.
local function preserve_diff_syntax()
  for _, group in ipairs({ "DiffAdd", "DiffChange", "DiffText", "DiffDelete" }) do
    local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
    -- Drop the foreground so underlying syntax colors show through; keep bg
    -- and any other attributes the colorscheme set.
    hl.fg = nil
    hl.ctermfg = nil
    vim.api.nvim_set_hl(0, group, hl)
  end
end

vim.api.nvim_create_autocmd("ColorScheme", {
  group = augroup("diff_preserve_syntax"),
  callback = preserve_diff_syntax,
})

-- Apply once for the colorscheme that's already active at startup.
preserve_diff_syntax()

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.opt_local.spell = true
  end,
})
