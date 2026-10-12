-- Snacks picker over the repo's open GitHub PRs, grouped like a review inbox:
-- mine, then ones requesting my review, then everything else. Selecting a PR
-- hands its number to `on_select` (a backend's PR-diff opener).
--
-- Built on Snacks' own `gh_pr` source, so the preview and its keys
-- (<a-b> browse, <c-y> yank) carry over.
local M = {}

local SECTIONS = {
  { name = "mine", hl = "DiagnosticOk", opts = { author = "@me" } },
  { name = "review", hl = "DiagnosticWarn", opts = { search = "review-requested:@me" } },
  { name = "repo", hl = "SnacksPickerDimmed", opts = {} },
}
local SECTION_WIDTH = 7

---@type snacks.picker.finder
local function finder(opts)
  local Api = require("snacks.gh.api")
  ---@async
  return function(cb)
    local seen = {} ---@type table<string, boolean>
    for _, section in ipairs(SECTIONS) do
      local list_opts = vim.tbl_extend("force", { state = "open", limit = opts.limit or 50 }, section.opts)
      Api.list("pr", function(items)
        for _, item in ipairs(items or {}) do
          if not seen[item.uri] then
            seen[item.uri] = true
            item.pr_section = section
            cb(item)
          end
        end
      end, list_opts):wait()
    end
  end
end

---@type snacks.picker.format
local function format(item, picker)
  local section = item.pr_section
  local ret = { { Snacks.picker.util.align(section.name, SECTION_WIDTH), section.hl } }
  vim.list_extend(ret, require("snacks.picker.source.gh").format(item, picker))
  return ret
end

---@param on_select fun(number: number)
function M.open(on_select)
  Snacks.picker.pick({
    source = "gh_pr",
    title = "  Open Pull Requests",
    finder = finder,
    format = format,
    live = false,
    supports_live = false,
    -- Keep the section order; matching still filters within it.
    sort = { fields = { "idx" } },
    matcher = { sort_empty = false },
    confirm = function(picker, item)
      picker:close()
      if item then
        vim.schedule(function()
          on_select(item.number)
        end)
      end
    end,
  })
end

return M
