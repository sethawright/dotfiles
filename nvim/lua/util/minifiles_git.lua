-- Narrow mini.files down to files git says changed. Two views mirror the
-- snacks pickers: "status" is the working tree against HEAD (like <leader>gs)
-- and "base" is everything since the branch left main/master, the way a pull
-- request's "Files changed" tab shows it (like <leader>gm). Both views also
-- show untracked files.
local M = {}

-- Which view the open explorer is showing, or nil for the normal unfiltered one.
M.mode = nil

-- vim.fn.system() mangles NUL bytes, so -z output needs vim.system().
local function git(args, cwd)
  local result = vim.system(vim.list_extend({ "git" }, args), { cwd = cwd, text = true }):wait()
  if result.code ~= 0 then
    return nil
  end
  return result.stdout or ""
end

-- Output of a git command run with -z, split into entries.
local function git_entries(args, cwd)
  local out = git(args, cwd)
  return out and vim.split(out, "\0", { trimempty = true }) or nil
end

local function status_files(root)
  local files, skip_next = {}, false
  for _, entry in ipairs(git_entries({ "status", "--porcelain", "-z", "--untracked-files=all" }, root) or {}) do
    if skip_next then
      -- The entry after a rename or copy is the old name.
      skip_next = false
    else
      local code, path = entry:match("^(..) (.*)$")
      if path then
        files[#files + 1] = path
        skip_next = code:find("[RC]") ~= nil
      end
    end
  end
  return files, "HEAD"
end

local function base_files(root)
  local base = require("util.pr_refs").default_branch()
  if not base then
    return nil, "couldn't find a main/master branch to diff against"
  end
  local files = git_entries({ "diff", "--name-only", "-z", "--merge-base", base }, root)
  if not files then
    return nil, "git diff against " .. base .. " failed"
  end
  vim.list_extend(files, git_entries({ "ls-files", "--others", "--exclude-standard", "-z" }, root) or {})
  return files, base
end

-- Returns root, relative paths, label (what the files changed against), or
-- nil and an error message.
local function changed(mode)
  local root = git({ "rev-parse", "--show-toplevel" }, vim.fn.getcwd())
  if not root then
    return nil, "not inside a git repository"
  end
  root = vim.trim(root)
  local files, label = (mode == "status" and status_files or base_files)(root)
  if not files then
    return nil, label
  end
  return root, files, label
end

-- Keeps changed files plus every directory on the way down to one.
local function build_filter(root, rel_paths)
  local keep = {}
  for _, rel in ipairs(rel_paths) do
    local path = root .. "/" .. rel
    keep[path] = true
    for dir in vim.fs.parents(path) do
      if keep[dir] then
        break
      end
      keep[dir] = true
    end
  end
  return function(fs_entry)
    -- Git reports real paths; the explorer may be anchored on a symlinked one.
    local path = vim.uv.fs_realpath(fs_entry.path) or fs_entry.path
    return keep[path] == true
  end
end

-- Directories from root down to the deepest one holding every changed file,
-- so the explorer opens already drilled in instead of at a lonely top level.
local function common_branch(root, rel_paths)
  local common
  for _, rel in ipairs(rel_paths) do
    local parts = vim.split(vim.fs.dirname(rel), "/", { trimempty = true })
    if parts[1] == "." then
      parts = {}
    end
    if not common then
      common = parts
    else
      local n = 0
      while n < #common and common[n + 1] == parts[n + 1] do
        n = n + 1
      end
      for i = #common, n + 1, -1 do
        common[i] = nil
      end
    end
  end
  local branch, path = { root }, root
  for _, part in ipairs(common or {}) do
    path = path .. "/" .. part
    branch[#branch + 1] = path
  end
  if #rel_paths == 1 then
    branch[#branch + 1] = root .. "/" .. rel_paths[1]
  end
  return branch
end

local function load(mode)
  local root, files, label = changed(mode)
  if not root then
    vim.notify(files, vim.log.levels.WARN, { title = "mini.files" })
    return nil
  end
  if #files == 0 then
    vim.notify("No files changed vs " .. label, vim.log.levels.INFO, { title = "mini.files" })
    return nil
  end
  vim.notify(("%d files changed vs %s"):format(#files, label), vim.log.levels.INFO, { title = "mini.files" })
  return root, files
end

local function default_filter()
  local MiniFiles = require("mini.files")
  return MiniFiles.config.content.filter or MiniFiles.default_filter
end

-- Open a fresh explorer at the git root showing only changed files.
---@param mode "status"|"base"
function M.open(mode)
  local root, files = load(mode)
  if not root then
    return
  end
  local MiniFiles = require("mini.files")
  MiniFiles.open(root, false, { content = { filter = build_filter(root, files) } })
  MiniFiles.set_branch(common_branch(root, files))
  M.mode = mode
end

-- Switch the open explorer to a changed-files view, or back to all files
-- when that view is already showing.
---@param mode "status"|"base"
function M.toggle(mode)
  local MiniFiles = require("mini.files")
  if M.mode == mode then
    M.mode = nil
    MiniFiles.refresh({ content = { filter = default_filter() } })
    return
  end
  local root, files = load(mode)
  if not root then
    return
  end
  MiniFiles.refresh({ content = { filter = build_filter(root, files) } })
  M.mode = mode
end

-- A fresh explorer starts unfiltered; `open` sets the mode again afterwards.
vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesExplorerOpen",
  callback = function()
    M.mode = nil
  end,
})

return M
