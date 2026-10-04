return {
  {
    "mxsdev/nvim-dap-vscode-js",
    dependencies = {
      "mfussenegger/nvim-dap",
      {
        "mason-org/mason.nvim",
        opts = { ensure_installed = { "js-debug-adapter" } },
      },
    },
    opts = {
      debugger_cmd = { vim.fn.stdpath("data") .. "/mason/bin/js-debug-adapter" },
      adapters = { "pwa-chrome" },
    },
    config = function(_, opts)
      require("dap-vscode-js").setup(opts)

      local dap = require("dap")
      dap.set_log_level("TRACE")
      dap.adapters["pwa-chrome"] = {
        type = "server",
        host = "127.0.0.1",
        port = "${port}",
        executable = {
          command = vim.fn.stdpath("data") .. "/mason/bin/js-debug-adapter",
          args = { "${port}", "127.0.0.1" },
        },
      }
      dap.configurations.javascript = dap.configurations.javascript or {}
      table.insert(dap.configurations.javascript, {
        type = "pwa-chrome",
        request = "launch",
        name = "Launch CTM in Chrome",
        runtimeExecutable = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome",
        url = "https://app.ctmdev.us",
        webRoot = "${workspaceFolder}",
        userDataDir = "/tmp/ctm-chrome-nvim-dap",
        sourceMapPathOverrides = {
          ["*.source.js"] = "${workspaceFolder}/app/assets/javascripts/*.js",
        },
        enableContentValidation = false,
        sourceMaps = true,
        pauseForSourceMap = true,
        trace = { logFile = "/tmp/ctm-js-debug.log" },
      })
      table.insert(dap.configurations.javascript, {
        type = "pwa-chrome",
        request = "launch",
        name = "Launch CTM in Arc",
        runtimeExecutable = "/Applications/Arc.app/Contents/MacOS/Arc",
        url = "https://app.ctmdev.us",
        webRoot = "${workspaceFolder}",
        userDataDir = "/tmp/ctm-arc-nvim-dap",
        sourceMapPathOverrides = {
          ["*.source.js"] = "${workspaceFolder}/app/assets/javascripts/*.js",
        },
        enableContentValidation = false,
        sourceMaps = true,
        pauseForSourceMap = true,
      })
      table.insert(dap.configurations.javascript, {
        type = "pwa-chrome",
        request = "attach",
        name = "Attach to CTM Chrome",
        address = "localhost",
        port = 9222,
        webRoot = "${workspaceFolder}",
        urlFilter = "https://sethwright.ngrok.io/*",
        targetSelection = "pick",
        sourceMapPathOverrides = {
          ["*.source.js"] = "${workspaceFolder}/app/assets/javascripts/*.js",
        },
        enableContentValidation = false,
        sourceMaps = true,
        pauseForSourceMap = true,
      })
    end,
  },
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

      return opts
    end,
  },
}
