return {
  {
    "VonHeikemen/lsp-zero.nvim",
    lazy = true,
    event = "BufReadPre",
    config = function()
      local lsp = require("lsp-zero")
      lsp.preset("recommended")
      lsp.on_attach(function(client, bufnr)
        lsp.default_keymaps({ buffer = bufnr })
        lsp.buffer_autoformat()
      end)
      lsp.set_sign_icons({
        error = "",
        warn = "",
        hint = "",
        info = "",
        other = "﫠",
      })
      lsp.nvim_workspace()
      lsp.setup()
    end,
    dependencies = {
      "nvim-lspconfig",
      "hrsh7th/nvim-cmp",
      "mason.nvim",
      "mason-lspconfig.nvim",
      "nvim-cmp",
      "cmp-nvim-lsp",
      "cmp_luasnip",
      "cmp-buffer",
      "cmp-path",
      "cmp-cmdline",
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      local null_ls = require("null-ls")

      local root_has_file = function(files)
        return function(utils)
          return utils.root_has_file(files)
        end
      end

      local eslint_root_files = { ".eslintrc", ".eslintrc.js", ".eslintrc.json" }
      local prettier_root_files = { ".prettierrc", ".prettierrc.js", ".prettierrc.json" }
      local stylua_root_files = { "stylua.toml", ".stylua.toml" }
      local elm_root_files = { "elm.json" }

      local opts = {
        eslint_formatting = {
          condition = function(utils)
            local has_eslint = root_has_file(eslint_root_files)(utils)
            local has_prettier = root_has_file(prettier_root_files)(utils)
            return has_eslint and not has_prettier
          end,
        },
        eslint_diagnostics = {
          condition = root_has_file(eslint_root_files),
        },
        prettier_formatting = {
          condition = root_has_file(prettier_root_files),
        },
        stylua_formatting = {
          condition = root_has_file(stylua_root_files),
        },
        elm_format_formatting = {
          condition = root_has_file(elm_root_files),
        },
      }

      local function on_attach(client, _)
        if client.server_capabilities.document_formatting then
          vim.cmd("command! -buffer Formatting lua vim.lsp.buf.formatting()")
          vim.cmd("command! -buffer FormattingSync lua vim.lsp.buf.formatting_sync()")
        end
      end

      null_ls.setup({
        sources = {
          null_ls.builtins.diagnostics.eslint_d.with(opts.eslint_diagnostics),
          null_ls.builtins.formatting.eslint_d.with(opts.eslint_formatting),
          null_ls.builtins.formatting.prettier.with(opts.prettier_formatting),
          null_ls.builtins.formatting.stylua.with(opts.stylua_formatting),
          null_ls.builtins.formatting.elm_format.with(opts.elm_format_formatting),
          null_ls.builtins.code_actions.eslint_d.with(opts.eslint_diagnostics),
        },
        on_attach = on_attach,
      })
    end,
  },
  { "neovim/nvim-lspconfig", lazy = true },
  { "williamboman/mason-lspconfig.nvim", lazy = true },
  { "williamboman/mason.nvim", lazy = true },
  {
    "hrsh7th/nvim-cmp",
    lazy = true,
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-.>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
      })
    end,
  },
  { "ray-x/lsp_signature.nvim", config = true },
  { "hrsh7th/cmp-nvim-lsp", lazy = true },
  { "hrsh7th/cmp-buffer", lazy = true },
  { "hrsh7th/cmp-path", lazy = true },
  { "hrsh7th/cmp-cmdline", lazy = true },
  { "saadparwaiz1/cmp_luasnip", lazy = true },
  { "L3MON4D3/LuaSnip", lazy = true },
  { "rafamadriz/friendly-snippets", lazy = true },
}
