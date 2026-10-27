-- Diffview shows git-blob content (other revisions, HEAD, staged index) in
-- buffers named "diffview://...". These aren't real paths on disk, and
-- feeding them into a server's root-dir detection can resolve to a bogus
-- root (e.g. "."), which some servers (e.g. denols) reject outright and
-- error on init. The real working-tree side of a diff is a normal buffer
-- with a real path, so it's unaffected by this guard.
local function is_diffview_buf(bufnr)
  return vim.api.nvim_buf_get_name(bufnr):match("^diffview://") ~= nil
end

local function guard_root_dir(name, sopts)
  local base = vim.lsp.config[name] or {}
  local orig_root_dir = sopts.root_dir or base.root_dir
  local orig_root_markers = sopts.root_markers or base.root_markers
  return function(bufnr, on_dir)
    if is_diffview_buf(bufnr) then
      return
    end
    if orig_root_dir then
      orig_root_dir(bufnr, on_dir)
    elseif orig_root_markers then
      on_dir(vim.fs.root(bufnr, orig_root_markers))
    end
  end
end

-- Only start Sorbet in projects that have a sorbet/config file.
local function sorbet_root_dir(bufnr, on_dir)
  local root = vim.fs.root(bufnr, function(name, path)
    if name ~= "sorbet" then
      return false
    end
    local dir = vim.fs.basename(path) == name and path or vim.fs.joinpath(path, name)
    return vim.uv.fs_stat(vim.fs.joinpath(dir, "config")) ~= nil
  end)
  if root then
    on_dir(root)
  end
end

return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts.inlay_hints = { enabled = false }
    opts.servers = opts.servers or {}
    opts.servers.denols = { enabled = true }
    opts.servers.oxlint = opts.servers.oxlint or {}
    opts.servers.oxfmt = opts.servers.oxfmt or {}
    opts.servers.graphql = opts.servers.graphql or {}

    -- Treesitter already highlights Ruby. ruby-lsp's semantic tokens add little
    -- and its replies to cancelled token requests raise NO_RESULT_CALLBACK_FOUND
    -- errors at startup, so stop asking for them.
    opts.servers.ruby_lsp = vim.tbl_deep_extend("force", opts.servers.ruby_lsp or {}, {
      on_attach = function(client)
        client.server_capabilities.semanticTokensProvider = nil
      end,
    })

    -- Sorbet runs from the project's bundle so it matches the pinned version.
    -- SRB_SKIP_GEM_RBIS stops the srb launcher from adding gem RBI folders as
    -- extra input directories, which the language server refuses to start with.
    opts.servers.sorbet = {
      mason = false,
      cmd = function(dispatchers, config)
        return vim.lsp.rpc.start({ "bundle", "exec", "srb", "tc", "--lsp" }, dispatchers, {
          cwd = config.root_dir,
          env = { SRB_SKIP_GEM_RBIS = "1" },
        })
      end,
      root_dir = sorbet_root_dir,
    }

    for name, sopts in pairs(opts.servers) do
      if name ~= "*" and sopts ~= false then
        if type(sopts) ~= "table" then
          sopts = {}
        end
        sopts.root_dir = guard_root_dir(name, sopts)
        opts.servers[name] = sopts
      end
    end

    return opts
  end,
}
