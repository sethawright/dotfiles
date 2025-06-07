set -gx EDITOR nvim
set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden --follow --glob "!{node_modules/*,vendor/*,.git/*}"'

set ANDROID_HOME ~/Library/Android/sdk

# set path
set PATH /usr/local/bin /opt/homebrew/bin /usr/local/sbin /usr/local/opt/ruby/bin /usr/bin /usr/bin /bin /usr/sbin /sbin /opt/X11/bin $PATH
set PATH $PATH /Users/sethwright/.cargo/bin
set PATH $PATH $(brew --prefix python)/libexec/bin
set PATH $PATH /Users/sethwright/.local/bin
set PATH $PATH vendor/bin
set PATH $PATH node_modules/.bin
set PATH $PATH $ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools

set -gx PNPM_HOME /Users/sethwright/Library/pnpm
set -gx PATH "$PNPM_HOME" $PATH

alias l="ls -lah"
alias puf='vendor/bin/phpunit --filter '
alias pu='vendor/bin/phpunit test'

alias firefox='open -a firefox'
alias preview='open -a Preview'
alias chrome='open -a Google\ Chrome'
alias safari='open -a Safari'
alias finder='open -a Finder'
alias tmsize='tmux detach -a'
alias c="code ."
alias v="nvim"
alias e="nvim"
alias vim="nvim"
alias m="nvim"
alias cleanup_branches="~/dotfiles/scripts/cleanup-branches.sh"
alias venv="source ./.venv/bin/activate.fish"

bind -s -k nul ~/dotfiles/scripts/tmux-sessionizer
alias tms="~/dotfiles/scripts/tmux-sessionizer"
alias tms="~/dotfiles/scripts/tmux-sessionizer"
alias gid="~/dotfiles/scripts/gh-issue-develop"

# git
alias lg="lazygit"
alias ld="lazydocker"

# tmux
alias td="tmux detach"

# git stuff
alias ga="gg a"
alias gac="gg c"
alias gc="gg cn"
alias gco="git checkout"
alias gd="git difftool"
alias gs="git status"
alias gl="gg l"
alias gp="gg p"
alias gpl="gg pl"
alias gph="git push -u origin HEAD"
alias q="/Users/sethwright/q/m64/q"

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
alias claude="/Users/sethwright/.claude/local/claude"
