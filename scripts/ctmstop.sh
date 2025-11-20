#!/bin/bash
# Graceful shutdown for ctm-server

echo "Stopping ctm-server services..."

# Send Ctrl-C to each window to gracefully stop processes
tmux send-keys -t ctm-server:rails C-c
tmux send-keys -t ctm-server:resque C-c
tmux send-keys -t ctm-server:scheduler C-c
tmux send-keys -t ctm-server:ctm-events C-c
tmux send-keys -t ctm-server:nginx C-c
tmux send-keys -t ctm-server:pool C-c
tmux send-keys -t ctm-server:logs C-c

# Wait a moment for graceful shutdown
sleep 3

# Stop docker containers
cd ~/Code/work/ctm && docker compose down

# Kill the tmux session
tmux kill-session -t ctm-server

echo "ctm-server stopped"
