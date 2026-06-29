return {
  {
    "rcarriga/nvim-dap-ui",
    optional = true,
    opts = function(_, opts)
      opts.layouts = opts.layouts or {
        {
          elements = {
            { id = "scopes", size = 0.25 },
            { id = "breakpoints", size = 0.25 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.25 },
          },
          position = "left",
          size = 40,
        },
        {
          elements = {
            { id = "repl", size = 0.5 },
            { id = "console", size = 0.5 },
          },
          position = "bottom",
          size = 10,
        },
      }

      -- layout 3: ruby bottom — repl only, no console
      table.insert(opts.layouts, {
        elements = { { id = "repl", size = 1.0 } },
        position = "bottom",
        size = 10,
      })

      local dap = require("dap")
      local dapui = require("dapui")

      -- swap to repl-only bottom when a ruby session starts
      dap.listeners.after.event_initialized["ruby_layout"] = function(session)
        if session.config.type == "ruby" then
          vim.schedule(function()
            dapui.close()
            dapui.open({ layout = 1 })
            dapui.open({ layout = 3 })
          end)
        end
      end

      return opts
    end,
  },
}
