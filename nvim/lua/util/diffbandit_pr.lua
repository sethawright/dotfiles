-- "Pull request" diff for diffbandit.nvim: what GitHub's "Files changed" tab
-- shows for a PR (the current branch's by default), i.e. the diff from the
-- merge-base with the PR's base branch, not a plain two-dot diff against the
-- branch tip.
--
-- Mirror of util.diffview_pr. diffbandit's `git_compare` does a merge-base
-- comparison by default (pass `direct = true` to get a two-dot diff), so
-- `git_compare(base, head)` matches diffview's `base...head`.
local M = {}

---@param number? number PR number; defaults to the current branch's PR
function M.open(number)
  local base, head, label = require("util.pr_refs").resolve(number)
  if not base then
    vim.notify("DiffBandit PR: " .. head, vim.log.levels.ERROR)
    return
  end
  vim.notify("DiffBandit " .. label)

  local session, err = require("diffbandit").git_compare(base, head)
  if not session and err then
    vim.notify("DiffBandit PR: " .. tostring(err), vim.log.levels.ERROR)
  end
end

return M
