-- Drop-in alternative to diffview.nvim. Enabled/disabled by the single
-- toggle in `util.diff_backend`; the `<leader>gv*` entry points mirror the
-- diffview spec so muscle memory carries over.
--
-- The in-view keymaps don't need remapping: diffbandit already ships the
-- same defaults this config relied on in diffview --
--   <Space> toggle stage for the hunk under the cursor
--   q       close the diff / commit panel
--   ]c / [c next / previous hunk
--   C       open / focus the commit panel (file-level staging lives here)

-- diffbandit derives its pane / context / sign-column / status backgrounds
-- from the `Normal` highlight. Our colorscheme runs transparent, so `Normal`
-- has no background and diffbandit falls back to solid black -- painting the
-- whole diff view dark. Strip that background back off so the terminal shows
-- through, matching the rest of the (transparent) editor. Runs after
-- diffbandit's own highlight pass, and on every ColorScheme so it survives
-- dark-notify's light/dark switching.
local function clear_diffbandit_backgrounds()
  -- Groups whose fg carries meaning (a diff color, a separator tint): only
  -- the background is dropped.
  local bg_only = {
    "DiffBanditContext",
    "DiffBanditSignColumn",
    "DiffBanditGap",
    "DiffBanditPlaceholder",
    "DiffBanditEmptyNotice",
    "DiffBanditConnectorContext",
    "DiffBanditConnectorExpansionAdd",
    "DiffBanditConnectorExpansionDelete",
    "DiffBanditConnectorExpansionChange",
    "DiffBanditConnectorExpansionAddUnderline",
  }
  for _, group in ipairs(bg_only) do
    local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
    if ok then
      hl.bg, hl.ctermbg = nil, nil
      pcall(vim.api.nvim_set_hl, 0, group, hl)
    end
  end

  -- Pane borders / separators: diffbandit's dynamic pass replaces its own
  -- `WinSeparator` link with a blend(Normal.bg, LineNr.fg) color, which looks
  -- wrong on a transparent (black) Normal. Both the normal split group and the
  -- "hidden" split group (used for the separators around the right content
  -- pane and the overview sidecar) get linked to WinSeparator so *every*
  -- separator matches nvim's WinSeparator exactly.
  pcall(vim.api.nvim_set_hl, 0, "DiffBanditSplit", { link = "WinSeparator" })
  pcall(vim.api.nvim_set_hl, 0, "DiffBanditHiddenSplit", { link = "WinSeparator" })

  -- Overview sidecar background: clear both fg and bg so the minimap column
  -- shows the terminal background through instead of a black strip.
  pcall(vim.api.nvim_set_hl, 0, "DiffBanditOverviewContext", { bg = "NONE", fg = "NONE" })

  -- Status line groups: fall back to the editor's real statusline highlights
  -- (which our colorscheme already renders transparent) instead of the
  -- near-black blend diffbandit computed from a black Normal.
  pcall(vim.api.nvim_set_hl, 0, "DiffBanditStatus", { link = "StatusLine" })
  pcall(vim.api.nvim_set_hl, 0, "DiffBanditStatusLine", { link = "StatusLine" })
  pcall(vim.api.nvim_set_hl, 0, "DiffBanditStatusAccent", { link = "StatusLine" })
  pcall(vim.api.nvim_set_hl, 0, "DiffBanditStatusMuted", { link = "StatusLineNC" })
end

return {
  "CoreyKaylor/diffbandit.nvim",
  enabled = require("util.diff_backend") == "diffbandit",
  lazy = true,
  keys = {
    -- DiffviewOpen -> changed-files panel + diff. diffbandit's file list and
    -- file/hunk staging live in the commit panel (diffbandit's analog to
    -- diffview's file panel), so open that rather than the bare `:DiffBanditGit`
    -- diff. Toggle the panel from within a diff with `C`; page files with ]f/[f.
    { "<leader>gvd", "<cmd>DiffBanditCommitPanel<cr>", desc = "DiffBandit Changes (commit panel)" },
    -- DiffviewFileHistory -> repo-wide commit log browser.
    { "<leader>gvh", "<cmd>DiffBanditGitLog<cr>", desc = "DiffBandit Git Log" },
    -- DiffviewFileHistory % -> history scoped to the current file.
    {
      "<leader>gvH",
      function()
        local path = vim.fn.expand("%:p")
        if path == "" then
          vim.notify("DiffBandit: no file in the current buffer", vim.log.levels.WARN)
          return
        end
        require("diffbandit").git_log({ pathspecs = { path } })
      end,
      desc = "DiffBandit Current File History",
    },
    -- PR diff (merge-base vs default branch).
    {
      "<leader>gvp",
      function()
        require("util.diffbandit_pr").open()
      end,
      desc = "DiffBandit PR (diff vs default branch)",
    },
  },
  opts = {},
  config = function(_, opts)
    require("diffbandit").setup(opts)

    -- Run once for the current colorscheme, then re-run after every
    -- ColorScheme. diffbandit registers its own ColorScheme handler during
    -- setup() above, so ours -- registered afterwards -- fires after it and
    -- overwrites the black backgrounds it just wrote.
    clear_diffbandit_backgrounds()
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("DiffBanditTransparency", { clear = true }),
      callback = clear_diffbandit_backgrounds,
    })

    -- Backtick toggles the changed-files panel ("file tree"), but ONLY inside
    -- a diffbandit diff/review tab -- every such tab carries the tabpage var
    -- `diffbandit_title`. Anywhere else it performs the native jump-to-mark
    -- motion, so this doesn't clobber the global key.
    --
    -- Three session shapes need three different toggles:
    --   * commit-panel host (gvd)          -> host:toggle_commit_panel()
    --   * plain git diff session (kind git) -> session:toggle_commit_panel()
    --   * compare/commit *review* (gvp/gvh) -> the built-in toggle routes
    --     through the review host's `close`, which tears down the whole
    --     review (looks like a "quit"), and its show is git-only. So hide/show
    --     the review's nav+commit windows directly, reusing diffbandit's own
    --     open_windows/attach for re-show. Everything is pcall-guarded: a
    --     failure no-ops rather than closing the review.
    local function valid_win(w)
      return w and vim.api.nvim_win_is_valid(w)
    end

    local function toggle_review_panel(sess)
      local panel_mod = require("diffbandit.panel")
      local p = sess.panel
      if not p then
        return
      end
      if p.visible and valid_win(p.nav_win) then
        -- HIDE. Focus a diff pane first so closing the panel windows can never
        -- remove the tab's last window (that is what read as a "quit"). If no
        -- diff pane is available to fall back to, refuse rather than risk it.
        local diff_win = (valid_win(sess.right_win) and sess.right_win)
          or (valid_win(sess.left_win) and sess.left_win)
        if not diff_win then
          return
        end
        pcall(vim.api.nvim_set_current_win, diff_win)
        for _, w in ipairs({ p.nav_win, p.commit_win }) do
          if valid_win(w) then
            pcall(vim.api.nvim_win_close, w, true) -- closes window only; buffer persists
          end
        end
        p.nav_win, p.commit_win, p.visible = nil, nil, false
        pcall(function() sess:resize_layout() end)
      else
        -- SHOW. Reuse the existing nav/commit buffers via diffbandit's own
        -- window opener + renderer. open_windows splits to the LEFT of the
        -- anchor, so anchor the left-most diff pane (mirroring diffbandit's own
        -- show_commit_panel) -- anchoring the right pane would drop the panel in
        -- the center gutter.
        local anchor = sess.left_win or sess.right_win or sess.left_header_win or vim.api.nvim_get_current_win()
        if pcall(panel_mod.open_windows, sess, anchor) then
          pcall(panel_mod.attach, sess)
          pcall(function() sess:resize_layout() end)
          pcall(panel_mod.focus_nav, sess)
        else
          p.visible = false
        end
      end
    end

    vim.keymap.set("n", "`", function()
      local tab = vim.api.nvim_get_current_tabpage()
      local ok, title = pcall(vim.api.nvim_tabpage_get_var, tab, "diffbandit_title")
      if not (ok and title) then
        vim.api.nvim_feedkeys("`", "n", false) -- native jump-to-mark
        return
      end
      local state = require("diffbandit.state")
      local host = state.panels[tab]
      if host and not host.disposed and type(host.toggle_commit_panel) == "function" then
        host:toggle_commit_panel() -- gvd commit-panel host
        return
      end
      local sess = state.sessions[tab]
      if not sess then
        return
      end
      -- A review panel (gvp compare / gvh commit) must NOT use the built-in
      -- toggle: its hide routes through the review host's close, tearing down
      -- the whole review. Only a non-review git session gets the built-in
      -- toggle; everything else is hidden/shown manually.
      local is_review = sess.panel
        and (sess.panel.mode == "review" or (((sess.file_queue or {}).opts or {}).read_only == true))
      if not is_review and sess.file_queue and sess.file_queue.kind == "git" then
        pcall(function() sess:toggle_commit_panel() end)
      else
        toggle_review_panel(sess)
      end
    end, { desc = "DiffBandit: toggle file panel (else native `)" })

    -- <C-h>/<C-l> pane navigation. A diffbandit diff is a row of windows
    -- (left content | line-numbers | connector gutter | line-numbers | right
    -- content), so smart-splits' one-window-at-a-time move lands in a gutter.
    -- Inside a diffbandit tab, feed diffbandit's own content-pane jumps
    -- (<C-w>h/<C-w>l, mapped buffer-locally on the content buffers) which skip
    -- the gutters; everywhere else defer to smart-splits (incl. tmux).
    local function pane_nav(dir)
      local wincmd_key = dir == "left" and "<C-w>h" or "<C-w>l"
      return function()
        local ok, title = pcall(vim.api.nvim_tabpage_get_var, 0, "diffbandit_title")
        if ok and title then
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(wincmd_key, true, false, true), "m", false)
        else
          require("smart-splits")["move_cursor_" .. dir]()
        end
      end
    end
    vim.keymap.set("n", "<C-h>", pane_nav("left"), { desc = "Move to left pane (diffbandit-aware)" })
    vim.keymap.set("n", "<C-l>", pane_nav("right"), { desc = "Move to right pane (diffbandit-aware)" })
  end,
}
