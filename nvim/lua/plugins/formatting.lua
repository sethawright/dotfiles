local function is_deno_project(ctx)
  return vim.fs.find({ "deno.json", "deno.jsonc" }, {
    path = ctx.dirname,
    upward = true,
  })[1] ~= nil
end

local function is_oxfmt_project(ctx)
  return vim.fs.find({ ".oxfmtrc.json", ".oxfmtrc.jsonc", "oxfmt.config.ts" }, {
    path = ctx.dirname,
    upward = true,
  })[1] ~= nil
end

local oxfmt_filetypes = {
  "css",
  "graphql",
  "html",
  "javascript",
  "javascriptreact",
  "json",
  "jsonc",
  "less",
  "scss",
  "typescript",
  "typescriptreact",
  "vue",
}

return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      local deno_filetypes = {
        "typescript",
        "typescriptreact",
        "javascript",
        "javascriptreact",
      }

      opts.formatters_by_ft = opts.formatters_by_ft or {}
      for _, ft in ipairs(deno_filetypes) do
        opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
        table.insert(opts.formatters_by_ft[ft], "deno_fmt")
      end

      for _, ft in ipairs(oxfmt_filetypes) do
        opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
        table.insert(opts.formatters_by_ft[ft], "oxfmt")
      end

      opts.formatters = opts.formatters or {}

      opts.formatters.deno_fmt = {
        condition = function(_, ctx)
          return is_deno_project(ctx)
        end,
      }

      opts.formatters.oxfmt = {
        condition = function(_, ctx)
          return not is_deno_project(ctx) and is_oxfmt_project(ctx)
        end,
      }

      local prev_condition = opts.formatters.prettier and opts.formatters.prettier.condition
      opts.formatters.prettier = vim.tbl_extend("force", opts.formatters.prettier or {}, {
        condition = function(self, ctx)
          if is_deno_project(ctx) or is_oxfmt_project(ctx) then
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
