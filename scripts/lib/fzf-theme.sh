#!/usr/bin/env bash
# One fzf palette for every picker here (tmux-sessionizer, tmux-worktreeizer),
# so they look like the same tool rather than three different ones.
#
# Matches the ghostty themes in ../../ghostty/config (Github Light Default and
# Github Dark Dimmed) and the tmux menu styles in ../../tmux-colors/, and
# follows the system appearance the same way they do -- resolved per call, not
# per shell, so switching light/dark mid-session takes effect on the next
# picker rather than the next login.
#
#   . "$(dirname "$0")/lib/fzf-theme.sh"
#   fzf --color="$(fzf_theme_colors)" ...
#
# Sourcing is optional for every caller: each falls back to fzf's own defaults
# if this file is missing, so the scripts still run standalone.

# light or dark. Prefers what tmux-dark-notify last wrote, since that is what
# the running tmux is themed to, and only asks macOS when that is absent.
fzf_theme_appearance() {
  local link
  link="$(readlink "${XDG_STATE_HOME:-$HOME/.local/state}/tmux/tmux-dark-notify-theme.conf" 2>/dev/null)"
  case $link in
  *light*)
    printf 'light'
    return
    ;;
  *dark*)
    printf 'dark'
    return
    ;;
  esac
  if [[ "$(defaults read -g AppleInterfaceStyle 2>/dev/null)" == Dark ]]; then
    printf 'dark'
  else
    printf 'light'
  fi
}

# The value for fzf's --color.
#
#   fzf_theme_colors [light|dark]
#
# bg and gutter stay -1 (the terminal's own background) so the picker sits on
# whatever ghostty is showing instead of painting its own slightly-wrong
# colour over it.
#
# The selected row is the one real fill: blue, at the luminance the terminal's
# own canvas has. One style for every picker and for the tmux menu (see
# ../../tmux-colors/), so they are all the same thing. It is this depth of
# blue rather than a vivid one because the worktree list colours its own rows
# and those ANSI colours survive on top of the highlight -- on a vivid
# #316dca they measure 1.03:1 (the dim column, i.e. gone) to 2.4:1, where
# here they are 2.5:1 to 6.2:1 dark and 4.0:1 to 4.7:1 light.
fzf_theme_colors() {
  local mode="${1:-$(fzf_theme_appearance)}"

  if [[ $mode == dark ]]; then
    # Github Dark Dimmed
    printf '%s' "\
fg:#adbac7,bg:-1,hl:#539bf5:bold,\
fg+:#cdd9e5:bold,bg+:#1c3159,hl+:#539bf5:bold,\
info:#768390,prompt:#539bf5:bold,pointer:#f47067,\
marker:#57ab5a,spinner:#b083f0,header:#768390,\
border:#6284b2,separator:#2d4a7a,scrollbar:#2d4a7a,\
gutter:#2d4a7a,query:-1:bold,label:#768390,\
preview-border:#6284b2,preview-label:#768390:bold"
  else
    # Github Light Default
    printf '%s' "\
fg:#1f2328,bg:-1,hl:#0969da:bold,\
fg+:#1f2328:bold,bg+:#ddf4ff,hl+:#0969da:bold,\
info:#656d76,prompt:#0969da:bold,pointer:#cf222e,\
marker:#1a7f37,spinner:#8250df,header:#656d76,\
border:#7b96b0,separator:#b6e3ff,scrollbar:#b6e3ff,\
gutter:#b6e3ff,query:-1:bold,label:#656d76,\
preview-border:#7b96b0,preview-label:#656d76:bold"
  fi
}
