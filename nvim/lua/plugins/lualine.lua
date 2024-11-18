return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local icons = LazyVim.config.icons
      local progressbar = function()
        local sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }
        local curr_line = vim.api.nvim_win_get_cursor(0)[1]
        local lines = vim.api.nvim_buf_line_count(0)
        local i = math.floor((curr_line - 1) / lines * #sbar) + 1
        return string.rep(sbar[i], 2)
      end
      opts.options = {
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha" } },
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      }
      opts.sections.lualine_a = {}
      opts.sections.lualine_b = {}
      opts.sections.lualine_c = {
        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
        { LazyVim.lualine.pretty_path() },
        "diagnostics",
      }
      opts.sections.lualine_x = {
        "branch",
        {
          "diff",
          symbols = {
            added = icons.git.added,
            modified = icons.git.modified,
            removed = icons.git.removed,
          },
        },
        progressbar,
      }
      opts.sections.lualine_y = {}
      opts.sections.lualine_z = {}
    end,
  },
}
