return {
  "sindrets/diffview.nvim",
  enabled = require("util.diff_backend") == "diffview",
  lazy = true,
  keys = {
    { "<leader>gvd", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
    {
      "<leader>gvm",
      function()
        -- Same base-branch pick as `<leader>gm`, but against the remote ref.
        -- Diff from the merge-base so only this branch's work shows (plus the
        -- working tree), not whatever landed on master since the branch point.
        local base = vim.fn.system("git rev-parse --verify --quiet origin/main"):find("^%x") and "origin/main"
          or "origin/master"
        local mb = vim.trim(vim.fn.system("git merge-base " .. base .. " HEAD"))
        vim.cmd("DiffviewOpen " .. (mb:find("^%x+$") and mb or base))
      end,
      desc = "Diffview Open (base branch)",
    },
    { "<leader>gvh", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview File History" },
    { "<leader>gvH", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview Current File History" },
  },
  opts = {
    show_help_hints = false,
    enhanced_diff_hl = true,
    hooks = {
      -- For added/deleted files, one side of the diff is an empty "null"
      -- buffer. Collapse that empty pane so only the meaningful content is
      -- shown (added file -> hide empty left; deleted file -> hide empty
      -- right). diffview's ensure_layout()/recover() rebuilds the pane
      -- automatically when navigating to a file that needs both sides.
      diff_buf_win_enter = function(_, _, _)
        vim.schedule(function()
          local view = require("diffview.lib").get_current_view()
          local layout = view and view.cur_layout
          if not layout then
            return
          end

          local nulled, live = {}, {}
          for _, win in ipairs(layout.windows or {}) do
            if win:is_valid() then
              table.insert(win:is_nulled() and nulled or live, win)
            end
          end

          -- Only collapse a plain 2-way diff where exactly one side is empty.
          if #live ~= 1 or #nulled ~= 1 then
            return
          end

          pcall(vim.api.nvim_win_close, nulled[1].id, false)
          pcall(vim.api.nvim_set_current_win, live[1].id)
        end)
      end,
    },
    view = {
      -- Full repo-relative path above each diff pane (the file panel truncates).
      default = {
        winbar_info = true,
      },
      file_history = {
        winbar_info = true,
      },
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
          "<cr>",
          function()
            require("diffview.actions").focus_entry()
          end,
          { desc = "Open the diff and focus the file pane", silent = true },
        },
        {
          "n",
          "`",
          function()
            require("diffview.actions").toggle_files()
          end,
          { desc = "Toggle the file panel", silent = true },
        },
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
        {
          "n",
          "`",
          function()
            require("diffview.actions").toggle_files()
          end,
          { desc = "Toggle the file panel", silent = true },
        },
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
