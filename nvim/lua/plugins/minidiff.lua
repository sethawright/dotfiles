-- The rail (mini.diff signs) never uses the git index as its reference, so
-- staging a file never blanks it out. `<leader>uG` switches between the two
-- references it does use. See `util.minidiff_ref`.
--
-- ]c / [c jump between hunks: "c" is change, the same thing it means inside a
-- real diff. ]C / [C go to the last / first hunk.
--
-- In a diff window (diffview, :diffthis) these fall through to vim's native
-- motions, which already walk the diff. Everywhere else they use mini.diff's
-- hunks, so they follow whichever mode <leader>uG is in.
local function hunk_jump(direction)
  return function()
    if vim.wo.diff then
      local native = direction == "first" and "gg]c"
        or direction == "last" and "G[c"
        or vim.v.count1 .. (direction == "next" and "]c" or "[c")
      pcall(vim.cmd, "normal! " .. native)
      return
    end
    if not pcall(require("mini.diff").goto_hunk, direction) then
      vim.notify("No diff hunks in this buffer", vim.log.levels.INFO)
    end
  end
end

return {
  {
    -- LazyVim gives ]c / [c / ]C / [C to treesitter class navigation, as
    -- buffer-local maps that would beat any global mapping. Drop them; the
    -- function and parameter motions (]f, ]a) are untouched.
    "nvim-treesitter/nvim-treesitter-textobjects",
    opts = function(_, opts)
      for _, keys in pairs(vim.tbl_get(opts, "move", "keys") or {}) do
        keys["]c"], keys["[c"], keys["]C"], keys["[C"] = nil, nil, nil, nil
      end
    end,
  },
  {
    "nvim-mini/mini.diff",
    keys = {
      { "]c", hunk_jump("next"), mode = { "n", "x" }, desc = "Next hunk" },
      { "[c", hunk_jump("prev"), mode = { "n", "x" }, desc = "Previous hunk" },
      { "]C", hunk_jump("last"), mode = { "n", "x" }, desc = "Last hunk" },
      { "[C", hunk_jump("first"), mode = { "n", "x" }, desc = "First hunk" },
    },
    opts = function(_, opts)
      local ref = require("util.minidiff_ref")
      opts.source = ref.source()

      Snacks.toggle({
        name = "Diff Rail: whole branch",
        get = function()
          return ref.get_mode() == "branch"
        end,
        set = function(state)
          ref.set_mode(state and "branch" or "worktree")
        end,
      }):map("<leader>uG")

      -- LazyVim's mini-diff extra put the signs on/off toggle on <leader>uG,
      -- which now switches mode instead. Keep on/off, one key over.
      Snacks.toggle({
        name = "Mini Diff Signs",
        get = function()
          return vim.g.minidiff_disable ~= true
        end,
        set = function(state)
          vim.g.minidiff_disable = not state
          if state then
            require("mini.diff").enable(0)
          else
            require("mini.diff").disable(0)
          end
          vim.defer_fn(function()
            vim.cmd([[redraw!]])
          end, 200)
        end,
      }):map("<leader>uR")
    end,
  },
}
