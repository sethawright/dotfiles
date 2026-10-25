-- PR review inside nvim: pick a PR, read the diff, comment, approve, merge.
-- Replaces the old diffview/diffbandit `<leader>gvp` flow. The other
-- `<leader>gv*` keys (local diffs, history) still belong to the diff backend.
return {
  "emrearmagan/atlas.nvim",
  lazy = true,
  cmd = "Atlas",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {
      "<leader>gvp",
      function()
        require("util.pr_picker").open(function(number)
          vim.cmd("Atlas review " .. number)
        end)
      end,
      desc = "Atlas PR review (pick an open PR)",
    },
  },
  ---@type AtlasConfig
  opts = {
    ui = {
      picker = "snacks",
    },
    -- GitHub counts as "not configured" until this key exists, and review
    -- refuses to open for an unconfigured provider. Auth comes from `gh`.
    providers = {
      github = {},
    },
    pulls = {
      diff = {
        -- "auto" would pick DiffviewOpen because diffview is installed, and
        -- that integration leans on diffview internals. Atlas's own viewer is
        -- the one that gets comments, threads and LSP support first.
        open_cmd = "AtlasDiff",
        layout = "side-by-side",
      },
    },
    keymaps = {
      pulls = {
        review = {
          atlas = {
            -- Backtick toggled the file panel in diffview and diffbandit too.
            toggle_explorer = { "`", "<leader>b" },
          },
        },
      },
    },
  },
}
