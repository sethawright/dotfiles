return {
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    ignored_filetypes = {
      "nofile",
      "quickfix",
      "prompt",
    },
    ignored_buftypes = { "NvimTree" },
    default_amount = 3,
    at_edge = "stop",
    move_cursor_same_row = false,

    ignored_events = {
      "BufEnter",
      "WinEnter",
    },

    keys = {
      {
        "<M-=>",
        function()
          require("smart-splits").resize_left()
        end,
        desc = "resize left",
      },
      {
        "<M-->",
        function()
          require("smart-splits").resize_right()
        end,
        desc = "resize right",
      },
      -- moving between splits
      {
        "<C-h>",
        function()
          require("smart-splits").move_cursor_left()
        end,
        desc = "move left",
      },
      {
        "<C-l>",
        function()
          require("smart-splits").move_cursor_right()
        end,
        desc = "move right",
      },
    },
  },
}
