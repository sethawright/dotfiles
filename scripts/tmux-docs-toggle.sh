#!/usr/bin/env bash

# Toggle the docs popup for the current tmux pane.
# Args (from tmux format string):
#   $1 = #{session_name}
#   $2 = #{window_name}

session_name=$1
window_name=$2

POPUP_NAME="docs"

# If we're already in a popup session (named "docs"), toggle within it.
if [[ "$session_name" == "$POPUP_NAME" ]]; then
  if [ "$window_name" = "$POPUP_NAME" ]; then
    # Second press inside docs window closes the popup.
    tmux detach-client
  else
    # Inside popup but not in docs: switch/create docs window.
    tmux select-window -t "$session_name:docs" 2>/dev/null ||
      tmux new-window -t "$session_name" -n docs -c "$HOME/Code/work/docs" "cd ~/Code/work/docs && nvim _index.md"
  fi
else
  # Create the popup session if it doesn't exist, then display popup
  if ! tmux has-session -t "$POPUP_NAME" 2>/dev/null; then
    tmux new-session -d -s "$POPUP_NAME" -n docs -c "$HOME/Code/work/docs" "cd ~/Code/work/docs && nvim _index.md"
  fi

  tmux display-popup -xC -yC -w 80% -h 75% \
    -E "tmux attach-session -t $POPUP_NAME"
fi
