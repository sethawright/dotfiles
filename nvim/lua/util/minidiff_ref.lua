-- mini.diff source with a switchable "what do we compare against" mode.
--
-- mini.diff's built-in git source compares the buffer with the git *index*,
-- so the moment a file is staged its signs disappear from the rail. Neither
-- mode here ever uses the index, so staged work always stays visible:
--
--   "worktree" -> compare with HEAD. Every line that is dirty in `git status`,
--                 staged or not.
--   "branch"   -> compare with the merge-base against the default branch.
--                 Every line this branch has touched, committed or not.
--
-- Switch with `<leader>uG`. The starting mode can be preset by setting
-- `vim.g.minidiff_ref_mode` before mini.diff loads.
local M = {}

local uv = vim.uv or vim.loop

M.modes = { "worktree", "branch" }

M.labels = {
  worktree = "Working tree (vs HEAD, staged included)",
  branch = "Whole branch (vs merge-base with default branch)",
}

local mode = M.labels[vim.g.minidiff_ref_mode] and vim.g.minidiff_ref_mode or "worktree"

-- buf id -> { fs_event, timer, git_dir }
local watchers = {}
-- git dir -> revision to diff against in the current mode
local rev_cache = {}
-- directory -> git dir, or false when the directory is not in a repo
local dir_cache = {}

local function git_out(args, cwd)
  local ok, res = pcall(function()
    return vim.system(args, { cwd = cwd, text = true }):wait(5000)
  end)
  if not ok or res.code ~= 0 or not res.stdout then
    return nil
  end
  local out = res.stdout:gsub("%s+$", "")
  return out ~= "" and out or nil
end

local function git_ok(args, cwd)
  local ok, res = pcall(function()
    return vim.system(args, { cwd = cwd }):wait(5000)
  end)
  return ok and res.code == 0
end

local function default_branch(cwd)
  local head = git_out({ "git", "symbolic-ref", "--short", "refs/remotes/origin/HEAD" }, cwd)
  if head then
    return head
  end
  for _, ref in ipairs({ "origin/main", "origin/master", "main", "master" }) do
    if git_out({ "git", "rev-parse", "--verify", "--quiet", ref }, cwd) then
      return ref
    end
  end
end

local function revision(git_dir, cwd)
  if mode ~= "branch" then
    return "HEAD"
  end
  if rev_cache[git_dir] then
    return rev_cache[git_dir]
  end
  local target = default_branch(cwd)
  local base = target and git_out({ "git", "merge-base", target, "HEAD" }, cwd)
  -- No branch point to compare with (no origin, orphan branch): fall back to
  -- HEAD so the rail still shows dirty lines instead of going blank.
  local rev = base or "HEAD"
  rev_cache[git_dir] = rev
  return rev
end

local function buf_path(buf_id)
  if not vim.api.nvim_buf_is_valid(buf_id) or vim.bo[buf_id].buftype ~= "" then
    return nil
  end
  local name = vim.api.nvim_buf_get_name(buf_id)
  if name == "" then
    return nil
  end
  return uv.fs_realpath(name) or name
end

local function git_dir_of(cwd)
  local cached = dir_cache[cwd]
  if cached ~= nil then
    return cached or nil
  end
  local dir = git_out({ "git", "rev-parse", "--path-format=absolute", "--git-dir" }, cwd)
  dir_cache[cwd] = dir or false
  return dir
end

local set_ref = vim.schedule_wrap(function(buf_id)
  if not vim.api.nvim_buf_is_valid(buf_id) then
    return
  end
  local apply = vim.schedule_wrap(function(text)
    pcall(MiniDiff.set_ref_text, buf_id, text)
  end)

  local path = buf_path(buf_id)
  if not path then
    return apply(nil)
  end
  local cwd, name = vim.fn.fnamemodify(path, ":h"), vim.fn.fnamemodify(path, ":t")
  local watcher = watchers[buf_id]
  local rev = revision(watcher and watcher.git_dir or cwd, cwd)

  vim.system(
    { "git", "show", rev .. ":./" .. name },
    { cwd = cwd, text = true },
    vim.schedule_wrap(function(res)
      if res.code == 0 and res.stdout and res.stdout ~= "" then
        return apply((res.stdout:gsub("\r\n", "\n")))
      end
      -- The file does not exist at that revision, so all of it is new work.
      -- Empty reference text marks every line as added. Untracked files count
      -- too; only ignored ones (build output, .env) stay quiet.
      if git_ok({ "git", "check-ignore", "-q", "--", name }, cwd) then
        return apply(nil)
      end
      apply("")
    end)
  )
end)

local function stop_watch(buf_id)
  local w = watchers[buf_id]
  watchers[buf_id] = nil
  if not w then
    return
  end
  pcall(function()
    w.fs_event:stop()
  end)
  pcall(function()
    w.timer:stop()
    w.timer:close()
  end)
end

local function attach(buf_id)
  if watchers[buf_id] ~= nil then
    return false
  end
  local path = buf_path(buf_id)
  if not path then
    return false
  end
  local cwd = vim.fn.fnamemodify(path, ":h")
  local git_dir = git_dir_of(cwd)
  if not git_dir then
    return false
  end

  local fs_event, timer = uv.new_fs_event(), uv.new_timer()
  watchers[buf_id] = { fs_event = fs_event, timer = timer, git_dir = git_dir }

  -- Any first-level change in the git dir (index, HEAD, ORIG_HEAD after a
  -- rebase) can move what we compare against, so recompute. Debounced because
  -- staging in a loop rewrites the index many times.
  fs_event:start(git_dir, {}, function()
    timer:stop()
    timer:start(50, 0, function()
      rev_cache[git_dir] = nil
      set_ref(buf_id)
    end)
  end)

  set_ref(buf_id)
end

local function apply_hunks()
  vim.notify(
    "mini.diff: the rail compares against " .. M.labels[mode]:lower() .. ", not the index, so it can not stage hunks."
      .. "\nUse the diff view (<leader>gvd) to stage.",
    vim.log.levels.WARN
  )
end

function M.source()
  vim.api.nvim_create_autocmd("BufUnload", {
    group = vim.api.nvim_create_augroup("MiniDiffRefMode", { clear = true }),
    callback = function(ev)
      stop_watch(ev.buf)
    end,
    desc = "Drop the git watcher for an unloaded buffer",
  })

  -- Fixed name: the source outlives any one mode, and mini.diff caches it
  -- into `vim.b.minidiff_summary.source_name`, where a stale mode would lie.
  return { name = "git-rail", attach = attach, detach = stop_watch, apply_hunks = apply_hunks }
end

function M.get_mode()
  return mode
end

function M.refresh()
  for buf_id in pairs(watchers) do
    set_ref(buf_id)
  end
end

function M.set_mode(new_mode)
  if not M.labels[new_mode] or new_mode == mode then
    return
  end
  mode = new_mode
  vim.g.minidiff_ref_mode = mode
  rev_cache = {}
  M.refresh()
end

function M.toggle()
  M.set_mode(mode == "branch" and "worktree" or "branch")
  vim.notify("Diff rail: " .. M.labels[mode])
end

return M
