#!/bin/sh

# Start a new tmux session named "ctm" and detach from it
tmux new-session -d -s ctm

# Split the window into four panes
tmux send-keys -t ctm "cd ~/Code/work/ctm && ./bin/run.sh" C-m
tmux split-window -h -t ctm
tmux send-keys -t ctm "cd ~/Code/work/ctm && ./bin/pool" C-m
tmux split-window -v -t ctm
tmux send-keys -t ctm "ctmcalls" C-m
tmux split-window -v -t ctm
tmux send-keys -t ctm "cd ~/Code/work/ctm && ./bin/new_scheduler.sh" C-m

# Attach to the session
# tmux attach-session -t ctm
