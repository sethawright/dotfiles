return {
  "sindrets/diffview.nvim",
  enabled = true,
  lazy = true,
  keys = {
    { "<leader>gvd", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
    { "<leader>gvh", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview File History" },
    { "<leader>gvH", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview Current File History" },
    {
      "<leader>gvp",
      function()
        require("util.diffview_pr").open()
      end,
      desc = "Diffview PR (diff vs default branch)",
    },
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
        {
          "n",
          "<space>",
          function()
            require("diffview.actions").toggle_stage_entry()
          end,
          { desc = "Stage / unstage the selected file", silent = true },
        },
      },
      view = {
        { "n", "<leader>q", "<Cmd>tabclose<CR>", { silent = true } },
        { "n", "<leader>q", "<Cmd>tabclose<CR>", { silent = true } },
        {
          "n",
          "<space>",
          function()
            require("util.diffview_hunk_stage").toggle()
          end,
          { desc = "Stage / unstage the hunk under the cursor", silent = true },
        },
      },
    },
  },
}
