return {
  "sindrets/diffview.nvim",
  enabled = true,
  lazy = true,
  keys = {
    { "<leader>gvd", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
    { "<leader>gvh", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview File History" },
    { "<leader>gvH", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview Current File History" },
  },
  opts = {
    show_help_hints = false,
    view = {
      merge_tool = {
        layout = "diff3_mixed",
      },
    },
    file_panel = {
      listing_style = "list",
    },
    keymaps = {
      file_panel = {
        { "n", "q", "<Cmd>tabclose<CR>", { silent = true } },
      },
      view = {
        { "n", "<leader>q", "<Cmd>tabclose<CR>", { silent = true } },
        { "n", "<leader>q", "<Cmd>tabclose<CR>", { silent = true } },
      },
    },
  },
}
