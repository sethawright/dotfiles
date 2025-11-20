# Start a new tmux session named "ctm-server" with the first window for rails
tmux new-session -d -s ctm-server -n "rails"

# Ensure docker dependencies are running first, then start rails
tmux send-keys -t ctm-server:rails "cd ~/Code/work/ctm && docker compose up -d && ./bin/run.sh" C-m

# Create new window for resque (jobs queue)
tmux new-window -t ctm-server -n "resque"
tmux send-keys -t ctm-server:resque "cd ~/Code/work/ctm && ./bin/pool" C-m

# Create new window for resque scheduler
tmux new-window -t ctm-server -n "scheduler"
tmux send-keys -t ctm-server:scheduler "cd ~/Code/work/ctm && ./bin/new_scheduler.sh" C-m

# Create new window for ctm-events (ngrok ws -> inflow)
tmux new-window -t ctm-server -n "ctm-events"
tmux send-keys -t ctm-server:ctm-events "ctmcalls" C-m

# Create new window for nginx
tmux new-window -t ctm-server -n "nginx"
tmux send-keys -t ctm-server:nginx "cd ~/Code/work/ctm-nginx && rake docker" C-m

# Create new window for pool
tmux new-window -t ctm-server -n "pool"
tmux send-keys -t ctm-server:pool "cd ~/Code/work/ctm-pool && ./bin/app.sh run" C-m

# Create new window for logs
tmux new-window -t ctm-server -n "logs"
tmux send-keys -t ctm-server:logs "cd ~/Code/work/ctm && tail -f log/development.log | grep LLOG" C-m

# Select the first window (rails) when attaching
tmux select-window -t ctm-server:rails
