stty -ixon

alias todo='vim ~/Dropbox/Documents/Todo/todo.md + -c "set norelativenumber nonumber invwrap wrap linebreak laststatus=0"'
alias espresso='open -a Espresso'
alias firefox='open -a firefox'
alias preview='open -a Preview'
alias chrome='open -a Google\ Chrome'
alias safari='open -a Safari'
alias mail='mutt -f ~/Mail/Swarm/INBOX'
alias service='mutt -f ~/Mail/Service/INBOX'
alias gmail='mutt -f ~/Mail/Gmail/INBOX'
alias unc='mutt -f ~/Mail/UNC/INBOX'
alias finder='open -a Finder'
alias tmsize='tmux detach -a'
alias swarmint='ssh swarmint@swarm.swarm1.com'
alias swarm1='ssh seth@swarm.swarmwebhosting.com'
alias swarm2='ssh seth@swarm.swarmwebhosting2.com'
alias swarm3='ssh seth@swarm.swarm1.com'
alias gridserver='ssh seth'
alias staging='ssh staging@swarm.swarm1.com'
alias redesign='ssh redesign@swarm.swarm1.com'
alias chat='mcabber'
alias dan='ssh danielniblock@192.168.1.13'
alias christine='ssh cmh@192.168.1.14'
alias scott='ssh Scott@192.168.1.17'
alias randall='ssh relmo@192.168.1.15'
alias render='ssh render@192.168.1.20'
alias timestamp='date +"%Y-%m-%d %H:%M:%S"'
alias v="vim ."
alias adbpic='adb shell screencap -p | perl -pe "s/\x0D\x0A/\x0A/g" > "/Users/seth/Downloads/firetvscreenshot_$(date +%Y%m%d-%H%M%S).png"'

alias gg='noglob gg'
alias ga="gg a"
alias gaa="git add ."
alias gc="git commit"
alias gco="git checkout"
alias gac="git commit -a"
alias gd="git difftool"
alias gs="git status;gg s"
alias gst="gs"
alias gp="git push"

# Customize to your needs...
export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/Users/asethwright/Dropbox/Swarm/Web/Script:/Users/asethwright/SSH:/Users/asethwright/Library/Android/sdk/platform-tools:$PATH
[[ $TMUX = "" ]] && export TERM="screen-256color"

source ~/.config/antigen/antigen.zsh

antigen use oh-my-zsh
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure
antigen bundle sublime
antigen bundle colorize
antigen bundle tmux
antigen bundle vi-mode

antigen apply

#BASE16_SHELL="$HOME/.config/base16-shell/base16-ocean.dark.sh"
#source $BASE16_SHELL

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
