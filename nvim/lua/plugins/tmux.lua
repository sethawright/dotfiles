return {
  {
    "mrjones2014/smart-splits.nvim",
    version = "v2.0.4",
    lazy = false,

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

      {
        "<C-j>",
        function()
          require("smart-splits").move_cursor_down()
        end,
        desc = "move down",
      },
      {
        "<C-k>",
        function()
          require("smart-splits").move_cursor_up()
        end,
        desc = "move up",
      },
    },
  },
}
