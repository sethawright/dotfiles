return {
  {
    "nvim-mini/mini-git",
    main = "mini.git",
    keys = {
      {
        "<leader>gb",
        function()
          require("util.git_blame").toggle()
        end,
        desc = "Git Blame (toggle)",
      },
    },
    config = function()
      require("mini.git").setup()

      vim.api.nvim_set_hl(0, "GitBlameHashRoot", { link = "Tag" })
      vim.api.nvim_set_hl(0, "GitBlameHash", { link = "Identifier" })
      vim.api.nvim_set_hl(0, "GitBlameAuthor", { link = "String" })
      vim.api.nvim_set_hl(0, "GitBlameDate", { link = "Comment" })
      vim.api.nvim_set_hl(0, "GitBlameEmail", { link = "Comment" })
    end,
  },
  {
    "nvim-mini/mini.files",
    opts = function(_, opts)
      opts.windows.preview = true
      local map_split = function(buf_id, lhs, direction)
        local rhs = function()
          -- Make new window and set it as target
          local cur_target = MiniFiles.get_explorer_state().target_window
          local new_target = vim.api.nvim_win_call(cur_target, function()
            vim.cmd(direction .. " split")
            return vim.api.nvim_get_current_win()
          end)

          MiniFiles.set_target_window(new_target)
        end

        -- Adding `desc` will result into `show_help` entries
        local desc = "Split " .. direction
        vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local buf_id = args.data.buf_id
          -- Tweak keys to your liking
          map_split(buf_id, "<C-s>", "belowright horizontal")
          map_split(buf_id, "<C-v>", "belowright vertical")

          local git_files = require("util.minifiles_git")
          vim.keymap.set("n", "gs", function()
            git_files.toggle("status")
          end, { buffer = buf_id, desc = "Toggle changed files (HEAD)" })
          vim.keymap.set("n", "gm", function()
            git_files.toggle("base")
          end, { buffer = buf_id, desc = "Toggle changed files (base branch)" })
        end,
      })
    end,
    keys = {
      {
        "<leader>e",
        function()
          local mini = require("mini.files")
          local buf_name = vim.api.nvim_buf_get_name(0)
          local path = vim.fn.filereadable(buf_name) == 1 and buf_name or vim.fn.getcwd()
          mini.open(path)
          mini.reveal_cwd()
        end,
        desc = "Open mini.files (cwd)",
      },
      {
        "<leader>ge",
        function()
          require("util.minifiles_git").open("base")
        end,
        desc = "Explorer: changed vs base branch",
      },
      {
        "<leader>gE",
        function()
          require("util.minifiles_git").open("status")
        end,
        desc = "Explorer: changed vs HEAD",
      },
    },
  },
}
