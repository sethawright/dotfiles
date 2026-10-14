-- A small pane under the Diffview file list that shows a PR's review state,
-- CI checks and whether it can merge. Opened by util.diffview_pr.
--
-- Keys in the pane: R refreshes, o opens the PR in the browser.
local M = {}

local POLL_MS = 30000
local ns = vim.api.nvim_create_namespace("diffview_pr_status")
local group = vim.api.nvim_create_augroup("DiffviewPrStatus", { clear = true })

-- One entry per tab that has a PR diff open.
---@type table<integer, { number: integer, buf: integer, win?: integer, panel_buf: integer, timer?: uv.uv_timer_t }>
local states = {}

local FIELDS = "number,state,isDraft,reviewDecision,latestReviews,reviewRequests,statusCheckRollup,mergeStateStatus"

local PASSED = { SUCCESS = true, NEUTRAL = true, SKIPPED = true }
local FAILED = {
  FAILURE = true,
  ERROR = true,
  CANCELLED = true,
  TIMED_OUT = true,
  STARTUP_FAILURE = true,
  ACTION_REQUIRED = true,
}

local REVIEW = {
  APPROVED = { "approved", "DiagnosticOk" },
  CHANGES_REQUESTED = { "changes requested", "DiagnosticError" },
  REVIEW_REQUIRED = { "review required", "DiagnosticWarn" },
}

local REVIEWER = {
  APPROVED = { "approved", "DiagnosticOk" },
  CHANGES_REQUESTED = { "changes", "DiagnosticError" },
  COMMENTED = { "commented", "Comment" },
  DISMISSED = { "dismissed", "Comment" },
}

local MERGE = {
  CLEAN = { "ready to merge", "DiagnosticOk" },
  HAS_HOOKS = { "ready to merge", "DiagnosticOk" },
  UNSTABLE = { "mergeable, checks failing", "DiagnosticWarn" },
  BLOCKED = { "blocked", "DiagnosticWarn" },
  BEHIND = { "behind base branch", "DiagnosticWarn" },
  DIRTY = { "has conflicts", "DiagnosticError" },
  DRAFT = { "draft", "Comment" },
  UNKNOWN = { "checking...", "Comment" },
}

-- Reruns leave the old runs in the rollup, so keep only the newest run of
-- each check.
local function latest_checks(rollup)
  local by_key, order = {}, {}
  for _, c in ipairs(rollup or {}) do
    local name = c.name or c.context or "?"
    local key = (c.workflowName or "") .. "/" .. name
    local when = c.startedAt or c.createdAt or ""
    local prev = by_key[key]
    if not prev then
      order[#order + 1] = key
    end
    if not prev or when >= prev.when then
      by_key[key] = { name = name, when = when, check = c }
    end
  end
  return vim.tbl_map(function(key)
    return by_key[key]
  end, order)
end

local function check_result(c)
  if c.__typename == "StatusContext" then
    if c.state == "SUCCESS" then
      return "passed"
    end
    return (c.state == "PENDING" or c.state == "EXPECTED") and "running" or "failed"
  end
  if c.status ~= "COMPLETED" then
    return "running"
  end
  if PASSED[c.conclusion] then
    return "passed"
  end
  return FAILED[c.conclusion] and "failed" or "passed"
end

-- Builds the pane as a list of lines, each a list of { text, hl } chunks.
local function build(pr)
  local lines = {}
  local function add(...)
    lines[#lines + 1] = { ... }
  end

  local state = pr.isDraft and "draft" or pr.state:lower()
  add({ " PR #" .. pr.number, "Title" }, { "  " .. state, "Comment" })

  local review = REVIEW[pr.reviewDecision] or { "no review needed", "Comment" }
  add({ " Review  ", "Comment" }, { review[1], review[2] })
  for _, r in ipairs(pr.latestReviews or {}) do
    local shown = REVIEWER[r.state] or { r.state:lower(), "Comment" }
    add({ "   " .. r.author.login .. " ", "Normal" }, { shown[1], shown[2] })
  end
  for _, req in ipairs(pr.reviewRequests or {}) do
    add({ "   " .. (req.login or req.name or req.slug or "?") .. " ", "Normal" }, { "waiting", "Comment" })
  end

  local checks = latest_checks(pr.statusCheckRollup)
  local counts, failed = { passed = 0, failed = 0, running = 0 }, {}
  for _, entry in ipairs(checks) do
    local result = check_result(entry.check)
    counts[result] = counts[result] + 1
    if result == "failed" then
      failed[#failed + 1] = entry.name
    end
  end
  if #checks == 0 then
    add({ " Checks  ", "Comment" }, { "none", "Comment" })
  else
    local parts = { { " Checks  ", "Comment" } }
    local function part(n, word, hl)
      if n > 0 then
        parts[#parts + 1] = { (#parts > 1 and ", " or "") .. n .. " " .. word, hl }
      end
    end
    part(counts.passed, "passed", "DiagnosticOk")
    part(counts.failed, "failed", "DiagnosticError")
    part(counts.running, "running", "DiagnosticWarn")
    add(unpack(parts))
    for _, name in ipairs(failed) do
      add({ "   x " .. name, "DiagnosticError" })
    end
  end

  if pr.state == "OPEN" then
    local merge = MERGE[pr.mergeStateStatus] or { pr.mergeStateStatus:lower(), "Comment" }
    add({ " Merge   ", "Comment" }, { merge[1], merge[2] })
  end

  return lines, counts.running > 0 or pr.mergeStateStatus == "UNKNOWN"
end

local function set_lines(buf, lines)
  local text = vim.tbl_map(function(chunks)
    return table.concat(vim.tbl_map(function(c)
      return c[1]
    end, chunks))
  end, lines)
  vim.bo[buf].modifiable = true
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, text)
  vim.bo[buf].modifiable = false
  vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
  for row, chunks in ipairs(lines) do
    local col = 0
    for _, c in ipairs(chunks) do
      vim.api.nvim_buf_set_extmark(buf, ns, row - 1, col, { end_col = col + #c[1], hl_group = c[2] })
      col = col + #c[1]
    end
  end
end

local function fit(state)
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_set_height(state.win, math.max(vim.api.nvim_buf_line_count(state.buf), 1))
  end
end

local function stop_timer(state)
  if state.timer then
    state.timer:stop()
    state.timer:close()
    state.timer = nil
  end
end

local refresh

local function schedule_poll(tab, state)
  stop_timer(state)
  state.timer = vim.uv.new_timer()
  state.timer:start(POLL_MS, 0, vim.schedule_wrap(function()
    if states[tab] == state then
      refresh(tab)
    end
  end))
end

refresh = function(tab)
  local state = states[tab]
  if not state then
    return
  end
  vim.system({ "gh", "pr", "view", tostring(state.number), "--json", FIELDS }, { text = true }, function(out)
    vim.schedule(function()
      if states[tab] ~= state or not vim.api.nvim_buf_is_valid(state.buf) then
        return
      end
      local ok, pr = pcall(vim.json.decode, out.stdout or "")
      if out.code ~= 0 or not ok then
        set_lines(state.buf, { { { " PR #" .. state.number .. "  couldn't load status", "DiagnosticError" } } })
        fit(state)
        return
      end
      local lines, unsettled = build(pr)
      set_lines(state.buf, lines)
      fit(state)
      -- Keep polling only while something can still change on its own.
      if unsettled then
        schedule_poll(tab, state)
      end
    end)
  end)
end

local function close_win(state)
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    pcall(vim.api.nvim_win_close, state.win, true)
  end
  state.win = nil
end

-- Puts the pane under the file list, if the file list is showing.
local function show(tab)
  local state = states[tab]
  if not state or (state.win and vim.api.nvim_win_is_valid(state.win)) then
    return
  end
  local panel_win = vim.fn.bufwinid(state.panel_buf)
  if panel_win == -1 or vim.api.nvim_win_get_tabpage(panel_win) ~= tab then
    return
  end
  state.win = vim.api.nvim_open_win(state.buf, false, {
    split = "below",
    win = panel_win,
    height = math.max(vim.api.nvim_buf_line_count(state.buf), 1),
  })
  local wo = vim.wo[state.win]
  wo.winfixheight = true
  wo.number = false
  wo.relativenumber = false
  wo.signcolumn = "no"
  wo.foldcolumn = "0"
  wo.cursorline = false
  wo.wrap = false
  wo.statusline = " "
  wo.winhighlight = "Normal:DiffviewNormal,EndOfBuffer:DiffviewEndOfBuffer"
end

local function teardown(tab)
  local state = states[tab]
  if not state then
    return
  end
  states[tab] = nil
  stop_timer(state)
  close_win(state)
  if vim.api.nvim_buf_is_valid(state.buf) then
    vim.api.nvim_buf_delete(state.buf, { force = true })
  end
end

local function new_buf(tab, number)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = "hide"
  vim.bo[buf].filetype = "DiffviewPrStatus"
  set_lines(buf, { { { " PR #" .. number .. "  loading...", "Comment" } } })
  vim.keymap.set("n", "R", function()
    refresh(tab)
  end, { buffer = buf, desc = "Refresh PR status" })
  vim.keymap.set("n", "o", function()
    vim.system({ "gh", "pr", "view", tostring(number), "--web" })
  end, { buffer = buf, desc = "Open PR in browser" })
  vim.keymap.set("n", "q", "<Cmd>tabclose<CR>", { buffer = buf, silent = true })
  return buf
end

-- Call right after the PR's Diffview has opened in the current tab.
---@param number integer
function M.attach(number)
  local view = require("diffview.lib").get_current_view()
  if not (view and view.panel and view.panel.bufid) then
    return
  end
  local tab = vim.api.nvim_get_current_tabpage()
  teardown(tab)
  states[tab] = { number = number, buf = new_buf(tab, number), panel_buf = view.panel.bufid }
  show(tab)
  refresh(tab)
end

-- Follow the file list as it is hidden and shown again.
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = group,
  callback = function(ev)
    local tab = vim.api.nvim_get_current_tabpage()
    local state = states[tab]
    if state and ev.buf == state.panel_buf then
      vim.schedule(function()
        show(tab)
      end)
    end
  end,
})

vim.api.nvim_create_autocmd("WinClosed", {
  group = group,
  callback = function(ev)
    local win = tonumber(ev.match)
    for _, state in pairs(states) do
      if win and vim.api.nvim_win_is_valid(win) and vim.api.nvim_win_get_buf(win) == state.panel_buf then
        vim.schedule(function()
          close_win(state)
        end)
      end
    end
  end,
})

vim.api.nvim_create_autocmd("TabClosed", {
  group = group,
  callback = function()
    for tab in pairs(states) do
      if not vim.api.nvim_tabpage_is_valid(tab) then
        teardown(tab)
      end
    end
  end,
})

return M
