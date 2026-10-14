-- Resolves the two refs for a "pull request" diff so it matches GitHub's
-- "Files changed" tab: the merge-base of the PR's own base branch (not always
-- main/master -- stacked PRs target another feature branch) against the
-- pushed PR head.
--
-- With no PR number, uses the current branch's PR. With no PR at all (or no
-- `gh`), falls back to the default branch against local HEAD.
local M = {}

local function ref_exists(ref)
  vim.fn.system({ "git", "rev-parse", "--verify", "--quiet", ref })
  return vim.v.shell_error == 0
end

function M.default_branch()
  local out = vim.fn.systemlist({ "git", "symbolic-ref", "--short", "refs/remotes/origin/HEAD" })
  if vim.v.shell_error == 0 and out[1] and out[1] ~= "" then
    return out[1]
  end

  for _, ref in ipairs({ "origin/main", "origin/master", "main", "master" }) do
    if ref_exists(ref) then
      return ref
    end
  end
end

local function view_pr(number)
  if vim.fn.executable("gh") ~= 1 then
    return nil
  end
  local args = { "gh", "pr", "view" }
  if number then
    args[#args + 1] = tostring(number)
  end
  vim.list_extend(args, { "--json", "number,baseRefName,headRefName,isCrossRepository" })
  local out = vim.fn.systemlist(args)
  if vim.v.shell_error ~= 0 then
    return nil
  end
  local ok, pr = pcall(vim.json.decode, table.concat(out, "\n"))
  return ok and pr or nil
end

local function fetch(args)
  vim.fn.system(vim.list_extend({ "git", "fetch", "--quiet", "origin" }, args))
  return vim.v.shell_error == 0
end

-- Returns `base, head, label, pr_number` (refs to pass as `base...head`), or
-- nil and an error message. pr_number is nil when there is no PR.
---@param number? number PR number; defaults to the current branch's PR
function M.resolve(number)
  local pr = view_pr(number)
  if not pr and number then
    return nil, "couldn't load PR #" .. number
  end
  if not pr then
    local target = M.default_branch()
    if not target then
      return nil, "couldn't find a main/master branch to diff against"
    end
    return target, "HEAD", target .. "...HEAD"
  end

  local base = "origin/" .. pr.baseRefName
  local head = "origin/" .. pr.headRefName

  if pr.isCrossRepository then
    -- A fork's head branch isn't on origin; GitHub keeps it at pull/N/head.
    -- Fetched alone so FETCH_HEAD is the head, not the base.
    fetch({ pr.baseRefName })
    if not fetch({ "pull/" .. pr.number .. "/head" }) then
      return nil, "git fetch failed for PR #" .. pr.number
    end
    head = vim.trim(vim.fn.system({ "git", "rev-parse", "FETCH_HEAD" }))
  elseif not fetch({ pr.baseRefName, pr.headRefName }) then
    vim.notify("PR diff: git fetch failed; using local origin refs", vim.log.levels.WARN)
  end

  return base, head, ("PR #%d: %s...%s"):format(pr.number, pr.baseRefName, pr.headRefName), pr.number
end

return M
