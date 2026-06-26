#!/usr/bin/env bash

if ! tmux has-session -t home 2>/dev/null; then
  tmux new-session -d -s home -n docs -c "$HOME/work/docs" "nvim _index.md; exec $SHELL"
  tmux new-window -t home: -n shell -c "$HOME"
  tmux select-window -t home:docs
fi

tmux attach -t home
