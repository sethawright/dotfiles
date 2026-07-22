-- Diffview shows git-blob content (other revisions, HEAD, staged index) in
-- buffers named "diffview://...". These aren't real paths on disk, and
-- feeding them into a server's root-dir detection can resolve to a bogus
-- root (e.g. "."), which some servers (e.g. denols) reject outright and
-- error on init. The real working-tree side of a diff is a normal buffer
-- with a real path, so it's unaffected by this guard.
local function is_diffview_buf(bufnr)
  return vim.api.nvim_buf_get_name(bufnr):match("^diffview://") ~= nil
end

local function guard_root_dir(name)
  local base = vim.lsp.config[name] or {}
  local orig_root_dir = base.root_dir
  local orig_root_markers = base.root_markers
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

return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts.inlay_hints = { enabled = false }
    opts.servers = opts.servers or {}
    opts.servers.denols = { enabled = true }
    opts.servers.oxlint = opts.servers.oxlint or {}
    opts.servers.oxfmt = opts.servers.oxfmt or {}
    opts.servers.graphql = opts.servers.graphql or {}

    for name, sopts in pairs(opts.servers) do
      if name ~= "*" and sopts ~= false then
        if type(sopts) ~= "table" then
          sopts = {}
        end
        sopts.root_dir = guard_root_dir(name)
        opts.servers[name] = sopts
      end
    end

    return opts
  end,
}
