return {
  "sindrets/diffview.nvim",
  lazy = true,
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
    { "<leader>gm", "<cmd>DiffviewOpen main<cr>", desc = "Diffview Open" },
    { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
    { "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview File History" },
    { "<leader>gH", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview Current File History" },
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
