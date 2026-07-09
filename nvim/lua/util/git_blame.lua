-- Custom, aligned git-blame gutter shown in a narrow split on the LEFT.
-- Renders only: short hash, human-readable (relative) time, and
-- "Author Name (githubuser)" — no source content, no line numbers.
local M = {}

local ns = vim.api.nvim_create_namespace("git_blame_custom")

-- Relative, human-readable time from a unix epoch.
local function relative_time(epoch)
  local diff = os.time() - epoch
  if diff < 0 then
    diff = 0
  end
  local minute, hour, day = 60, 3600, 86400
  local week, month, year = day * 7, day * 30, day * 365
  local function ago(n, unit)
    return string.format("%d %s%s ago", n, unit, n == 1 and "" or "s")
  end
  if diff < minute then
    return "just now"
  elseif diff < hour then
    return ago(math.floor(diff / minute), "minute")
  elseif diff < day then
    return ago(math.floor(diff / hour), "hour")
  elseif diff < week then
    return ago(math.floor(diff / day), "day")
  elseif diff < month then
    return ago(math.floor(diff / week), "week")
  elseif diff < year then
    return ago(math.floor(diff / month), "month")
  else
    return ago(math.floor(diff / year), "year")
  end
end

-- Commit author email, with the porcelain "<...>" wrapper stripped.
local function author_email(mail)
  if not mail or mail == "" then
    return nil
  end
  mail = mail:gsub("^<", ""):gsub(">$", "")
  return mail ~= "" and mail or nil
end

-- Parse `git blame --line-porcelain` into one record per source line.
local function parse_porcelain(out)
  local records, cur = {}, nil
  for _, line in ipairs(out) do
    local hash = line:match("^(%x+) %d+ %d+")
    if hash then
      cur = { hash = hash }
      records[#records + 1] = cur
    elseif cur then
      if line:sub(1, 1) ~= "\t" then
        local key, val = line:match("^(%S+) (.*)$")
        if key == "author" then
          cur.author = val
        elseif key == "author-mail" then
          cur.mail = val
        elseif key == "author-time" then
          cur.time = tonumber(val)
        elseif line == "boundary" then
          cur.boundary = true
        end
      end
    end
  end
  return records
end

-- Build display lines + extmark highlight specs from records.
local function build(records)
  local lines, hls = {}, {}

  -- Pad the date column to the widest label actually present, so short
  -- relative times ("3 days ago") don't leave a big fixed gap.
  local date_width = 0
  for _, rec in ipairs(records) do
    if not rec.hash:match("^0+$") then
      date_width = math.max(date_width, #(rec.time and relative_time(rec.time) or ""))
    end
  end

  for i, rec in ipairs(records) do
    local li = i - 1
    local uncommitted = rec.hash:match("^0+$")

    if uncommitted then
      lines[i] = "Uncommitted"
      hls[#hls + 1] = { line = li, col = 0, end_col = #lines[i], hl = "Comment" }
    else
      local short = rec.hash:sub(1, 8)
      local when = string.format("%-" .. date_width .. "s", rec.time and relative_time(rec.time) or "")
      local name = rec.author or ""
      local email = author_email(rec.mail)
      local who = email and (name .. " (" .. email .. ")") or name

      lines[i] = short .. "  " .. when .. "  " .. who

      -- hash
      hls[#hls + 1] =
        { line = li, col = 0, end_col = #short, hl = rec.boundary and "GitBlameHashRoot" or "GitBlameHash" }
      -- date (highlight only the visible text, not trailing padding)
      local date_start = #short + 2
      hls[#hls + 1] =
        { line = li, col = date_start, end_col = date_start + #vim.trim(when), hl = "GitBlameDate" }
      -- author name
      local who_start = date_start + #when + 2
      hls[#hls + 1] = { line = li, col = who_start, end_col = who_start + #name, hl = "GitBlameAuthor" }
      -- (email)
      if email then
        hls[#hls + 1] = { line = li, col = who_start + #name + 1, end_col = who_start + #who, hl = "GitBlameEmail" }
      end
    end
  end
  return lines, hls
end

local AUGROUP = "GitBlameFollow"

-- There is at most one blame panel at a time. It follows a source window and
-- re-blames whatever file that window shows.
--   state = { panel = <win>, pbuf = <buf>, src = <win> }
local state = nil

-- Run git blame for a buffer; return (lines, hls) or nil if it has no
-- blameable file on disk / isn't tracked.
local function blame_for(buf)
  local file = vim.api.nvim_buf_get_name(buf)
  if file == "" or vim.fn.filereadable(file) == 0 then
    return nil
  end
  local dir = vim.fn.fnamemodify(file, ":h")
  local out = vim.fn.systemlist({ "git", "-C", dir, "blame", "--line-porcelain", "--", file })
  if vim.v.shell_error ~= 0 then
    return nil
  end
  return build(parse_porcelain(out))
end

local function render(pbuf, lines, hls)
  vim.bo[pbuf].modifiable = true
  vim.api.nvim_buf_set_lines(pbuf, 0, -1, false, lines)
  vim.api.nvim_buf_clear_namespace(pbuf, ns, 0, -1)
  for _, h in ipairs(hls or {}) do
    vim.api.nvim_buf_set_extmark(pbuf, ns, h.line, h.col, { end_col = h.end_col, hl_group = h.hl })
  end
  vim.bo[pbuf].modifiable = false
end

local function set_binds(on)
  if state.src and vim.api.nvim_win_is_valid(state.src) then
    vim.wo[state.src].scrollbind, vim.wo[state.src].cursorbind = on, on
  end
  if state.panel and vim.api.nvim_win_is_valid(state.panel) then
    vim.wo[state.panel].scrollbind, vim.wo[state.panel].cursorbind = on, on
  end
end

-- Re-blame the source window's current buffer into the panel.
local function refresh()
  if not state or not vim.api.nvim_win_is_valid(state.panel) or not vim.api.nvim_win_is_valid(state.src) then
    return
  end
  local src_buf = vim.api.nvim_win_get_buf(state.src)
  local lines, hls = blame_for(src_buf)
  if not lines then
    set_binds(false)
    render(state.pbuf, { "(no blame)" }, {})
    return
  end
  render(state.pbuf, lines, hls)
  local topline = vim.fn.line("w0", state.src)
  local lnum = math.min(vim.api.nvim_win_get_cursor(state.src)[1], math.max(#lines, 1))
  vim.api.nvim_win_call(state.panel, function()
    vim.fn.winrestview({ topline = topline, lnum = lnum, col = 0 })
  end)
  set_binds(true)
  vim.api.nvim_win_call(state.src, function()
    vim.cmd("syncbind")
  end)
end

-- Close the panel and drop all binds/autocmds. Reentrant-safe.
function M.close()
  if not state then
    return
  end
  local s = state
  state = nil
  pcall(vim.api.nvim_del_augroup_by_name, AUGROUP)
  if s.panel and vim.api.nvim_win_is_valid(s.panel) then
    pcall(vim.api.nvim_win_close, s.panel, true)
  end
  if s.src and vim.api.nvim_win_is_valid(s.src) then
    vim.wo[s.src].scrollbind, vim.wo[s.src].cursorbind = false, false
  end
end

function M.open()
  M.close()

  local src_win = vim.api.nvim_get_current_win()
  local src_buf = vim.api.nvim_get_current_buf()
  local lines, hls = blame_for(src_buf)
  if not lines then
    vim.notify("git blame: not a tracked file on disk", vim.log.levels.WARN)
    return
  end
  if vim.bo[src_buf].modified then
    vim.notify("git blame: buffer has unsaved changes; blame reflects the saved file", vim.log.levels.WARN)
  end

  local pbuf = vim.api.nvim_create_buf(false, true)
  vim.bo[pbuf].buftype = "nofile"
  vim.bo[pbuf].bufhidden = "wipe"
  vim.bo[pbuf].filetype = "gitblamecustom"

  -- Open the split on the left of the source window.
  vim.cmd("aboveleft vsplit")
  local panel = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(panel, pbuf)
  vim.api.nvim_win_set_width(panel, math.max(35, math.floor(vim.o.columns * 0.25)))

  local wo = vim.wo[panel]
  wo.number, wo.relativenumber = false, false
  wo.signcolumn, wo.foldcolumn = "no", "0"
  wo.wrap, wo.list = false, false
  wo.cursorline, wo.winfixwidth = true, true

  state = { panel = panel, pbuf = pbuf, src = src_win }

  render(pbuf, lines, hls)
  local topline = vim.fn.line("w0", src_win)
  local lnum = math.min(vim.api.nvim_win_get_cursor(src_win)[1], math.max(#lines, 1))
  vim.api.nvim_win_call(panel, function()
    vim.fn.winrestview({ topline = topline, lnum = lnum, col = 0 })
  end)
  set_binds(true)
  vim.api.nvim_win_call(src_win, function()
    vim.cmd("syncbind")
  end)

  vim.keymap.set("n", "q", M.close, { buffer = pbuf, nowait = true, desc = "Close git blame" })
  vim.keymap.set("n", "<Esc>", M.close, { buffer = pbuf, nowait = true, desc = "Close git blame" })

  -- Follow the source window: re-blame whenever it shows a different buffer
  -- (or the file is written). Registered last so building the panel above
  -- doesn't trigger it. Tear down if either window closes.
  local group = vim.api.nvim_create_augroup(AUGROUP, { clear = true })
  vim.api.nvim_create_autocmd({ "BufWinEnter", "BufWritePost" }, {
    group = group,
    callback = function()
      if state and vim.api.nvim_get_current_win() == state.src then
        vim.schedule(refresh)
      end
    end,
  })
  vim.api.nvim_create_autocmd("WinClosed", {
    group = group,
    callback = function(ev)
      if state then
        local w = tonumber(ev.match)
        if w == state.src or w == state.panel then
          M.close()
        end
      end
    end,
  })

  -- Return focus to the source so you can keep reading code.
  vim.api.nvim_set_current_win(src_win)
end

function M.toggle()
  if state then
    M.close()
  else
    M.open()
  end
end

return M
