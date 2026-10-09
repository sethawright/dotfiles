#!/usr/bin/env bash
# Reaching tmux on the other machines in the tailnet, for the pickers that
# list them next to the local ones (tmux-session-switcher, tmux-sessionizer).
#
#   . "$(dirname "$0")/lib/tmux-remote.sh"
#   remote_sh sethmb <<<'tmux list-sessions'
#   attach_remote sethmb notes
#
# Nothing here needs these scripts on the other machine: everything it runs
# there is plain sh and tmux.

# A non-interactive ssh command gets the bare system PATH on macOS, which has
# no Homebrew tmux in it, and the login shell over there may be fish. So every
# remote command is sh, with this PATH, and env sets it without caring which
# shell runs the line.
remote_path='/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin'

# BatchMode so a host that wants a password or an unknown host key is skipped
# rather than hanging the popup; ConnectTimeout for peers that are asleep.
ssh_opts=(-o BatchMode=yes -o ConnectTimeout=3)

# Not filtered on .Online: it is the coordination server's view and reads
# false for an idle Mac that still answers ssh. ConnectTimeout already bounds
# a peer that really is gone, and callers ask the peers in parallel.
#
# The MagicDNS label, not .HostName: HostName is the device's display name
# ("Seth’s MacBook Air"), which neither resolves nor survives word splitting.
tailscale_peers() {
  command -v tailscale >/dev/null && command -v jq >/dev/null || return
  tailscale status --json 2>/dev/null |
    jq -r '.Peer[] | select(.OS == "macOS" or .OS == "linux") | .DNSName | split(".")[0]'
}

# Runs the sh script on stdin on the host.
remote_sh() {
  ssh "${ssh_opts[@]}" "$1" "env PATH=$remote_path sh -s"
}

# Runs the sh script on stdin on every peer at once, printing each line it
# outputs as "host<TAB>line" as soon as it arrives rather than when the
# slowest peer is done. Line by line on purpose: the peers share one pipe,
# and a single short write is the unit that never interleaves with another.
each_peer() {
  local script host
  script="$(cat)"
  for host in $(tailscale_peers); do
    remote_sh "$host" <<<"$script" 2>/dev/null |
      awk -v host="$host" '{ print host "\t" $0; fflush() }' &
  done
  wait
}

# Puts this terminal into the host's session. Inside tmux it detaches this
# client and runs ssh in its place, so the remote tmux gets the prefix key
# instead of nesting under this one, and detaching over there attaches back
# to the session the picker was opened from.
attach_remote() {
  local host=$1 session=$2
  local attach="ssh -t $host \"env PATH=$remote_path tmux attach -t '$session'\""

  if [[ -z $TMUX ]]; then
    eval "exec $attach"
  fi

  local origin
  origin="$(tmux display-message -p '#{session_name}')"
  tmux detach-client -E "$attach; tmux attach -t '$origin'"
}
