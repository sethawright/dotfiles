return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    opts = {
      window = {
        mappings = {
          ["v"] = "open_vsplit",
          ["s"] = "open_split",
        },
      },
      event_handlers = {
        {
          event = "file_opened",
          handler = function()
            require("neo-tree").close_all()
          end,
        },
      },
    },
  },
}
