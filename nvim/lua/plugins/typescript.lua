return {
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact", "javascript.jsx", "typescript.tsx" },
    opts = {},
    keys = {
      {
        "gD",
        "<cmd>TSToolsGoToSourceDefinition<cr>",
        desc = "Goto Source Definition",
        ft = { "typescript", "typescriptreact", "javascript", "javascriptreact", "javascript.jsx", "typescript.tsx" },
      },
      {
        "gR",
        "<cmd>TSToolsFileReferences<cr>",
        desc = "File References",
        ft = { "typescript", "typescriptreact", "javascript", "javascriptreact", "javascript.jsx", "typescript.tsx" },
      },
      {
        "<leader>co",
        "<cmd>TSToolsOrganizeImports<cr>",
        desc = "Organize Imports",
        ft = { "typescript", "typescriptreact", "javascript", "javascriptreact", "javascript.jsx", "typescript.tsx" },
      },
      {
        "<leader>cM",
        "<cmd>TSToolsAddMissingImports<cr>",
        desc = "Add missing imports",
        ft = { "typescript", "typescriptreact", "javascript", "javascriptreact", "javascript.jsx", "typescript.tsx" },
      },
      {
        "<leader>cu",
        "<cmd>TSToolsRemoveUnusedImports<cr>",
        desc = "Remove unused imports",
        ft = { "typescript", "typescriptreact", "javascript", "javascriptreact", "javascript.jsx", "typescript.tsx" },
      },
      {
        "<leader>cD",
        "<cmd>TSToolsFixAll<cr>",
        desc = "Fix all diagnostics",
        ft = { "typescript", "typescriptreact", "javascript", "javascriptreact", "javascript.jsx", "typescript.tsx" },
      },
      {
        "<leader>cR",
        "<cmd>TSToolsRemoveUnused<cr>",
        desc = "Remove all unused",
        ft = { "typescript", "typescriptreact", "javascript", "javascriptreact", "javascript.jsx", "typescript.tsx" },
      },
      {
        "<leader>cs",
        "<cmd>TSToolsSortImports<cr>",
        desc = "Sort imports",
        ft = { "typescript", "typescriptreact", "javascript", "javascriptreact", "javascript.jsx", "typescript.tsx" },
      },
      {
        "<leader>cN",
        "<cmd>TSToolsRenameFile<cr>",
        desc = "Rename file",
        ft = { "typescript", "typescriptreact", "javascript", "javascriptreact", "javascript.jsx", "typescript.tsx" },
      },
    },
  },
}
