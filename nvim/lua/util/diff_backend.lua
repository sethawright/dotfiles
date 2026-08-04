-- Single source of truth for which git-diff UI is active.
--
-- Flip this one string and restart nvim (or `:Lazy reload` the relevant
-- plugin) to swap backends. The two plugin specs derive their `enabled`
-- flag from this value, so exactly one of them is ever active and their
-- (identical) `<leader>gv*` keymaps never clash.
--
--   "diffview"   -> sindrets/diffview.nvim
--   "diffbandit" -> CoreyKaylor/diffbandit.nvim
return "diffbandit"
