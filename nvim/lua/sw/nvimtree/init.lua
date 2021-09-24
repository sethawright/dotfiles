local tree_cb = require'nvim-tree.config'.nvim_tree_callback
--
-- -- vim.g.nvim_tree_disable_window_picker = 1
vim.g.nvim_tree_bindings = {
  { key = {"v"}, cb = tree_cb("vsplit") },
  { key = {"s"}, cb = tree_cb("vsplit") },
  { key = {"r"}, cb = tree_cb("system_open") },
  { key = {"m"}, cb = tree_cb("rename") },
  { key = {"t"}, cb = tree_cb("tabnew") },
  { key = {"<Tab>"}, cb = tree_cb("preview") },
}
