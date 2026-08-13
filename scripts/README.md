# tmux-worktreeizer

Pick a git worktree, get a tmux session for it. Then, if you want it, a way to
run several copies of a multi-repo stack side by side — each with its own ports,
its own hostname, and its own slice of whatever else it needs.

The tool knows about worktrees, tmux, fzf and ports. It knows nothing about your
application. Everything that only your repos can know goes in a **hook**.

Needs `bash`, `git`, `tmux`, `fzf`. `gh` for pull request status, `foreman` for
Procfiles, `lsof` for run status — each optional, and absent means that column
or feature is simply quiet.

---

## The picker

Bind it to a key (see *Installing*), or run `tmux-worktreeizer`. Backtick cycles
three modes.

**repos** — one row per repo. Enter opens a folder.

```
* ~/src/api             [master]   pushed                  2 worktrees
  ~/src/web             [master]   pushed
```

**worktrees** — everything flattened, so typing `api` finds all of them. Each
row carries its repo name because fzf can only match on what it displays.

```
> api/fix-timeouts      [fix-timeouts]  +2      :20040   PR #412 open
! api/other             [other]         no-remote  dead
  web/busy-gould        [(detached)]    detached           agent
```

**envs** — a name shared by worktrees in several repos (see *Envs*).

```
> fix-timeouts   fix-timeouts.test   :20040   2/2 up   2 repos: api, web
```

### Columns

| | |
|---|---|
| `>` | serving: something is listening on its port |
| `!` | crashed: the server window has a dead pane |
| `*` | a tmux session exists, nothing running |
| name | `repo/worktree` |
| `[branch]` | shown when it differs from the directory name |
| status | `pushed`, `+2/-1`, `no-remote`, `gone`, `detached` |
| run | `:20040`, `booting`, `dead` |
| `PR #n` | from a cached `gh pr list` |
| tags | `agent`, `live`, `locked`, `prunable` |

`live` means an agent process has that worktree as its working directory — no
integration with the agents themselves, just `pgrep` plus one `lsof`, so it says
"something is working in here" rather than what it is doing.
`TW_AGENT_PATTERN` sets which process names count.

Run status comes from three batched calls (two `lsof`, one `tmux list-panes -a`),
so it costs the same for three rows or three hundred.

### Keys

| key | |
|---|---|
| enter | open the folder / open the session / start the create flow |
| `` ` `` | cycle repos → worktrees → envs, or step back out |
| backspace | step out of a folder once the query is empty |
| tab / shift-tab | jump to the next / previous repo |
| ctrl-space | start the repo's processes, or stop them |
| ctrl-t | create a worktree in the repo under the cursor |
| ctrl-x | remove the worktree and kill its session, then offer to delete the branch too (kept unless you say otherwise) |
| ctrl-d | close the tmux session only -- worktree and branch untouched, no confirmation |
| ctrl-r | refresh the pull request cache |
| ctrl-s | `git fetch --prune` |
| ctrl-o | open a browser: the pull request on a worktree row, the env's host on an env row |

These stay off the keys fzf uses for moving and editing (`ctrl-a b c e f g h i
j l n p q u w y`, `ctrl-/`). Two deliberate exceptions: tab, because its
default needs `--multi`, which this does not use; and ctrl-d, which is really
fzf's delete-char/eof, taken anyway because it was the key wanted for closing
a session. The cost: pressing it with a query typed closes a session instead
of deleting a character. Alt is avoided on purpose too: terminals that compose
Option into characters (ghostty by default) would deliver `alt-j` as `∆`
straight into the query.

---

## Hooks

**Anything specific to a repository belongs in a hook.** Five hooks, all
optional. Four of them are per repo, with **two places** each:

```
in the repo       <repo>/bin/<hook>.sh   or  <repo>/bin/<hook>
on this machine   $TMW_DIR/repos/<repo>/<hook>   or  $TMW_DIR/hooks/<hook>
```

`$TMW_DIR` defaults to `~/.config/tmw`.

**`setup`, `teardown` and `env` run both**, the repo's first, so a personal hook
adds to the committed one rather than replacing it. `teardown` runs them in
reverse, so whatever the machine added comes off before the repo's own cleanup.
`run` takes only one — starting two servers makes no sense — and there the
personal hook wins.

Write the repo's hook so it works on its own, with none of this tool's variables
set. That way a teammate who has never heard of it gets working setup from
`bin/setup.sh`, and everything here is an optional extra layer on top. Deriving
things from git rather than from `TW_*` is usually all it takes:

```bash
main="${TW_MAIN:-$(cd "$(git rev-parse --path-format=absolute --git-common-dir)/.." && pwd)}"
```

| hook | when | what it is for |
|---|---|---|
| `setup` | after a worktree is created | make the checkout runnable: install dependencies, create a database, copy the files git ignores |
| `run` | ctrl-space, if there is no Procfile | start the thing |
| `teardown` | after a worktree is removed | undo what setup provisioned |
| `env` | whenever env variables are handed out | translate this tool's facts into the names your code reads |
| `manifest` | after every create or remove | react to envs.json changing, e.g. reload a proxy |

`setup`, `run` and `teardown` are ordinary scripts, run with the worktree as the
working directory (`teardown` runs from the main checkout, since the worktree is
already gone by then). `env` is different: it **prints `KEY=VALUE` lines** on
stdout, and they get added to the environment.

`manifest` is different too: it is not about any one repo (a create or remove
in any repo can change an env's membership), so there is no repo to resolve it
against and no repo-committed half — just one optional script at
`$TMW_DIR/hooks/manifest`, run after the manifest is rewritten. The tool
rewrites `envs.json` itself on every create and remove now, so this hook only
needs to react to it, not trigger it.

### The env hook

This is where the interesting repo-specific work happens. The tool exports
facts in its own names; the hook turns them into your application's:

```bash
#!/usr/bin/env bash
# $TMW_DIR/hooks/env

printf 'MYAPP_ENV=%s\n'  "$TW_ENV"
printf 'MYAPP_HOST=%s\n' "$TW_ENV_HOST"

# a block of 20 redis databases per env, above whatever dev and test already use
printf 'MYAPP_REDIS_DB=%s\n' "$((32 + 20 * (TW_ENV_INDEX - 1)))"

# where a peer lives, but only when this env actually contains it
[[ -n ${TW_WEB_PORT:-} ]] && printf 'MYAPP_WEB_URL=http://127.0.0.1:%s\n' "$TW_WEB_PORT"
```

In its environment:

| | |
|---|---|
| `TW_ENV` | the env name |
| `TW_ENV_INDEX` | a small stable integer for that name, for deriving blocks |
| `TW_ENV_HOST` | hostname from `TW_ENV_HOST_PATTERN` |
| `TW_ENV_DOMAIN` | the configured domain |
| `TW_ENV_REPOS` | the repos in this env, space separated |
| `TW_PORT_BASE`, `TW_PORT_SPAN` | the env's port block |
| `TW_<REPO>_PORT`, `TW_<REPO>_HOST` | one pair per repo in the env |
| `TW_REPO`, `TW_WORKTREE`, `TW_PORT`, `PORT` | this worktree, when asking about one |
| `TW_MAIN` | the main checkout, for copying or linking the files git ignores |

Print nothing and nothing changes. **Leave a variable unset when the env does
not contain that service**, and have your config fall back:

```ruby
:api => ENV['MYAPP_WEB_URL'] || 'http://127.0.0.1:3000'
```

That single `||` is what makes partial envs work: a worktree gets its own copy
of the services it has worktrees for, and the shared ones for everything else.

### Copying and linking what git ignores

A fresh worktree has none of the gitignored files the main checkout accumulated:
`.env`, seed data, caches, log directories. That is a `setup` hook, and it needs
no configuration language of its own:

```bash
#!/usr/bin/env bash
# <repo>/bin/setup.sh -- runs in the new worktree
main="${TW_MAIN:-$(cd "$(git rev-parse --path-format=absolute --git-common-dir)/.." && pwd)}"

mkdir -p log tmp/pids                       # directories the app insists on
cp -n "$main/.env" .env 2>/dev/null         # copy what each checkout may diverge on
ln -sfn "$main/db/seeds" db/seeds           # link what they can share
```

Copy what a worktree might edit; link what is reference data. Dependencies are
usually better installed than copied — a package manager that finds a tree it
did not create tends to make a mess of it.

### Running things

ctrl-space runs, in the session's `server` window:

1. `Procfile.dev`, else `Procfile` — via `foreman start`, all entries in the one
   window, each line prefixed with the process name.
2. otherwise the `run` hook.
3. otherwise `bin/debug.sh`, `bin/run.sh`, `bin/dev.sh`.

A second press stops it. Nothing there means nothing happens.

ctrl-t runs this too, automatically, right after setup — creating a worktree
for something runnable starts it running, rather than leaving ctrl-space as
the next keystroke. Silently skipped when there is nothing to run. The same
checks ctrl-space does on its own still apply: a taken port, or another live
env sharing this one's redis/mysql/elasticsearch, still ask before starting.

Put workers and schedulers in the Procfile too, not just the web process — with
per-env queues, the main checkout's workers are looking somewhere else and would
never pick up this env's jobs.

Two things worth knowing about foreman: it stops **every** process when any one
of them exits, so a single flaky entry looks like "the env is broken"; and it
assigns `PORT` per process itself, so the tool passes `-p` to keep the env's
port. Also don't put a script that is *itself* `foreman start` into a Procfile —
nesting means an inner failure tears the outer one down.

---

## Envs

**An env is a name.** Every worktree called that name, in any repo, is part of
it. Repos without one are not in the env, and callers fall back to their main
checkout — so a change in one repo that needs a change in another means using
the same worktree name in both.

Worktrees live at `$TW_ROOT/<repo>/<name>`, so membership is a directory
listing. Nothing is registered anywhere, and deleting a directory is enough to
leave.

### Ports are derived, not allocated

```
base = TW_ENV_PORT_BASE + (cksum(env name) % TW_ENV_SLOTS) * TW_ENV_PORT_SPAN
port for a repo = base + (its index among the env's repos) * 4
```

No ledger to corrupt, stable across restarts, and every participant — the tool,
your proxy, the run scripts — computes the same numbers without talking to each
other. Four apart because a service can want more than one: a rails app may
take three (web, debugger, control app) and a front end two.

### The manifest

Written to `~/.cache/tmux-worktreeizer/envs.json` automatically after every
create or remove (and by `tmux-worktreeizer --manifest` directly, if you want
it without either):

```json
{ "domain": "test",
  "envs": { "fix-timeouts": {
      "prefix": "fix-timeouts",
      "primary_host": "fix-timeouts.test",
      "port_base": 20040,
      "services": { "api": { "path": "...", "branch": "...", "port": 20040 } }}}}
```

A proxy can render one server block per env from it. Note the tool publishes a
**prefix**, not a hostname per service: only your proxy knows which name each
service answers on, whether two of them share an upstream, or that one is a path
rather than a hostname. Let it put the prefix in front of its own names.

If you do that, two things to get right:

- Give each env **uniquely named upstreams** and set `proxy_cache_key` to
  include `$host`. nginx's default key uses `$proxy_host`, so otherwise two envs
  can serve each other's cached responses.
- Put the include **after** your existing server blocks, unless you declare a
  `default_server`. The first block for a port becomes the default, and an env
  should not become the default for unmatched hostnames.

---

## Installing

```bash
git clone <this> ~/src/tmux-worktreeizer
ln -s ~/src/tmux-worktreeizer/tmux-worktreeizer ~/.local/bin/tmw
```

A tmux binding, in `tmux.conf`:

```tmux
bind-key -n M-. display-popup -d "#{pane_current_path}" -xC -yC -w 90% -h 80% -E "tmw"
```

On macOS, terminals that leave Option as Option send a composed character rather
than `M-.`, so bind that character instead — `≥` for Option-. on a US layout —
and keep `M-.` for terminals where Option really is Alt.

Settings go in `$TMW_DIR/config`, which is sourced before defaults are applied:

```bash
TW_ROOT="$HOME/src/.worktrees"
TW_ROOTS="$HOME/src:$HOME/work"
TW_ENV_DOMAIN="test"
TW_ENV_HOST_PATTERN='{env}.{domain}'
```

| setting | default |
|---|---|
| `TW_ROOT` | `~/work/.worktrees` — where new worktrees go |
| `TW_ROOTS` | colon separated directories scanned for repos |
| `TW_REPOS` | colon separated extra repo paths |
| `TW_EDITOR` | the editor window's command — `$EDITOR`, then `vi` |
| `TW_ENV_DOMAIN` | `localhost` |
| `TW_ENV_HOST_PATTERN` | `{env}.{domain}` |
| `TW_ENV_PORT_BASE`, `TW_ENV_PORT_SPAN`, `TW_ENV_SLOTS` | 20000, 40, 500 |
| `TW_BRANCH_PREFIX` | prefills the new-branch prompt |
| `TW_PR_TTL` | 900 — pull request cache age |
| `TW_NO_FETCH` | set to skip the fetch in the create flow |
| `TW_AGENT_PATTERN` | `claude\|codex\|opencode\|aider\|gemini` |
| `TMW_DIR` | `~/.config/tmw` |

Other entry points: `tmw --new [repo]`, `tmw --manifest`,
`tmw --env-exports <env> [repo]`, `tmw --help`.

---

## Notes on behaviour

- **Sessions are reused.** Opening a worktree attaches to any session already
  rooted at that path, whatever it is called, rather than making a second one.
- **Agent worktrees are shown but never provisioned.** Anything under
  `.claude/worktrees` or `.codex/worktrees` is tagged `agent`, and because it is
  not under `$TW_ROOT` it is not part of an env — so teardown never fires for
  it.
- **Removal keeps the branch by default.** `git worktree remove`, then
  `teardown`, and only if the removal succeeded. Dirty or locked worktrees
  prompt first; a locked one needs `--force` twice, which the tool handles.
  Afterward it offers to delete the branch too -- opt in, since the worktree
  going away is routine but discarding a branch (and any commits not merged
  anywhere) is not.
- **`.env.worktree`** is written in each env worktree and added to
  `.git/info/exclude`, so it never shows up in `git status`. The run command
  sources it, because `tmux set-environment` does not reach a respawned window.
- **A dead server window is kept** (`remain-on-exit`), so a failed start leaves
  its error on screen instead of vanishing.
- **The port is checked before starting.** If something else already holds it,
  the tool says which process rather than starting a doomed duplicate.
