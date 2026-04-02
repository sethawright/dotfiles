local function is_deno_project(ctx)
  return vim.fs.find({ "deno.json", "deno.jsonc" }, {
    path = ctx.dirname,
    upward = true,
  })[1] ~= nil
end

return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      local deno_filetypes = {
        "typescript",
        "typescriptreact",
        "javascript",
        "javascriptreact",
        "json",
        "jsonc",
        "markdown",
        "css",
        "html",
        "yaml",
      }

      opts.formatters_by_ft = opts.formatters_by_ft or {}
      for _, ft in ipairs(deno_filetypes) do
        opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
        table.insert(opts.formatters_by_ft[ft], "deno_fmt")
      end

      opts.formatters = opts.formatters or {}

      -- deno_fmt only runs in Deno projects
      opts.formatters.deno_fmt = {
        condition = function(_, ctx)
          return is_deno_project(ctx)
        end,
      }

      -- Exclude Deno projects from prettier
      local prev_condition = opts.formatters.prettier and opts.formatters.prettier.condition
      opts.formatters.prettier = vim.tbl_extend("force", opts.formatters.prettier or {}, {
        condition = function(self, ctx)
          if is_deno_project(ctx) then
            return false
          end
          if prev_condition then
            return prev_condition(self, ctx)
          end
          return true
        end,
      })
    end,
  },
}
