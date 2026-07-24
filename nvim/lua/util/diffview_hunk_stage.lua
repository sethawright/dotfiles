-- Stage/unstage the hunk under the cursor while viewing a diffview.nvim diff.
--
-- diffview.nvim only ships file-level staging (`s`/`-` in the file panel).
-- Hunk-level staging works by writing to the buffer that represents the git
-- index (diffview intercepts `:w` on that buffer and updates the index for
-- you), combined with vim's native `:diffget`/`:diffput`. Both commands act
-- on the diff block under the cursor in the *current* window, so we never
-- need to move focus to the index window (its cursor position isn't
-- otherwise in sync with the window we're leaving).
local M = {}

function M.toggle()
  local lib = require("diffview.lib")
  local RevType = require("diffview.vcs.rev").RevType

  local view = lib.get_current_view()
  if not (view and view.cur_entry and view.cur_layout) then
    return
  end

  -- Only meaningful for the default `:DiffviewOpen` (index vs working tree).
  if not (view.left.type == RevType.STAGE and view.right.type == RevType.LOCAL) then
    return
  end

  local kind = view.cur_entry.kind
  if kind ~= "working" and kind ~= "staged" then
    return
  end

  local layout = view.cur_layout
  -- "working" (unstaged changes): index is on the left (`a`).
  -- "staged" (staged changes vs HEAD): index is on the right (`b`).
  local index_win = kind == "working" and layout.a or layout.b

  if not (index_win and index_win:is_valid()) then
    return
  end

  local cur_win = vim.api.nvim_get_current_win()
  if cur_win ~= layout.a.id and cur_win ~= layout.b.id then
    return
  end

  pcall(vim.cmd, cur_win == index_win.id and "diffget" or "diffput")

  if vim.bo[index_win.file.bufnr].modified then
    vim.api.nvim_buf_call(index_win.file.bufnr, function()
      vim.cmd("silent write")
    end)
  end
end

return M
