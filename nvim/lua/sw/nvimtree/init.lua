local tree_cb = require'nvim-tree.config'.nvim_tree_callback

-- vim.g.nvim_tree_disable_window_picker = 1
vim.g.nvim_tree_bindings = {
  ["v"] = tree_cb("vsplit"),
  ["s"] = tree_cb("split"),
  ["t"] = tree_cb("tabnew")
}
