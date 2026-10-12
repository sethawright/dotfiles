-- "Pull request" diff: what GitHub's "Files changed" tab shows for a PR (the
-- current branch's by default), i.e. the diff from the merge-base with the
-- PR's base branch, not a plain two-dot diff against the branch tip. See
-- util.pr_refs.
local M = {}

---@param number? number PR number; defaults to the current branch's PR
function M.open(number)
  local base, head, label = require("util.pr_refs").resolve(number)
  if not base then
    vim.notify("Diffview PR: " .. head, vim.log.levels.ERROR)
    return
  end
  vim.notify("Diffview " .. label)
  vim.cmd("DiffviewOpen " .. base .. "..." .. head)
end

return M
