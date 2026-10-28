#!/usr/bin/env bash
# Point *.ctmdev.us at this MacBook (local) or at seth-mini over Tailscale (mini).
# dnsmasq only reads address= lines at start, so a swap restarts it.
# The targets end in .target so Homebrew's dnsmasq.d/*.conf glob loads only the active symlink.
set -euo pipefail

dir=/opt/homebrew/etc/dnsmasq.d
active="$dir/ctmdev-active.conf"

case "${1:-status}" in
  local|mini)
    ln -sfn "ctmdev-$1.target" "$active"
    sudo brew services restart dnsmasq >/dev/null
    sudo dscacheutil -flushcache
    sudo killall -HUP mDNSResponder
    ;;
  status) ;;
  *)
    echo "usage: ctmdev local|mini|status" >&2
    exit 2
    ;;
esac

target="$(basename "$(readlink "$active")" .target)"
echo "ctmdev.us -> ${target#ctmdev-}"
ip="$(dscacheutil -q host -a name app.ctmdev.us | awk '/^ip_address/ {print $2; exit}')"
echo "app.ctmdev.us resolves to ${ip:-nothing}"
