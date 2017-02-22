stty -ixon
export HISTIGNORE="jrnl *"

KEYTIMEOUT=1
source ~/.config/antigen/antigen.zsh

antigen use oh-my-zsh
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure
antigen bundle sublime
antigen bundle colorize
antigen bundle tmux
antigen bundle vi-mode

antigen apply

alias todo='vim ~/Dropbox/Documents/Todo/todo.md + -c "set norelativenumber nonumber laststatus=0" -c "VimwikiIndex"'
alias org='vim ~/Dropbox/Documents/Todo/todo.md + -c "set norelativenumber nonumber laststatus=0" -c "VimwikiIndex"'
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
alias swarm1='ssh swarm1'
alias swarm2='ssh swarm2'
alias swarm3='ssh seth@swarm.swarm1.com'
alias gridserver='ssh seth'
alias staging='ssh staging@swarm.swarm1.com'
alias redesign='ssh redesign@swarm.swarm1.com'
alias chat='mcabber'
alias dan='ssh danielniblock@192.168.1.13'
alias christine='ssh cmh@192.168.1.14'
alias scott='ssh Scott@192.168.1.17'
alias randall='ssh relmo@192.168.1.15'
alias intern='ssh render@192.168.1.19'
alias render='ssh render@192.168.1.20'
alias linux='ssh linux'
alias timestamp='date +"%Y-%m-%d %H:%M:%S"'
alias v="vim ."
alias n="nvim ."
alias e="vim"
alias s="subl ."
alias adbpic='adb shell screencap -p | perl -pe "s/\x0D\x0A/\x0A/g" > "/Users/seth/Downloads/firetvscreenshot_$(date +%Y%m%d-%H%M%S).png"'
alias firetv='adb kill-server && adb start-server && adb connect 192.168.1.104'
alias news="newsbeuter"

if [ -n "$TMUX" ]; then
  # Tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  printf_template="\033Ptmux;\033\033]4;%d;rgb:%s\007\033\\"
  printf_template_var="\033Ptmux;\033\033]%d;rgb:%s\007\033\\"
  printf_template_custom="\033Ptmux;\033\033]%s%s\007\033\\"
elif [ "${TERM%%-*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  printf_template="\033P\033]4;%d;rgb:%s\007\033\\"
  printf_template_var="\033P\033]%d;rgb:%s\007\033\\"
  printf_template_custom="\033P\033]%s%s\007\033\\"
else
  printf_template="\033]4;%d;rgb:%s\033\\"
  printf_template_var="\033]%d;rgb:%s\033\\"
  printf_template_custom="\033]%s%s\033\\"
fi

# quick theme switching
alias dark='base16_materialdark'
alias light='base16_materiallight'
alias cursor_magenta='printf $printf_template_custom Pl e1bee7' # cursor
alias cursor_yellow='printf $printf_template_custom Pl ffff8d' # cursor
alias cursor_red='printf $printf_template_custom Pl ff8a80' # cursor
alias cursor_orange='printf $printf_template_custom Pl f96a38' # cursor
alias cursor_blue='printf $printf_template_custom Pl 82b1ff' # cursor
alias cursor_green='printf $printf_template_custom Pl b9f6ca' # cursor

alias gg='noglob gg'
alias ga="gg a"
alias gaa="git add ."
alias gc="git commit"
alias gco="git checkout"
alias gac="git commit -a"
alias gd="git difftool"
alias gs="git status; echo ""; gg s"
alias gst="gs"
alias gp="git push"

# Customize to your needs...
export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:$PATH
export PATH=$PATH:/Users/seth/Dropbox/Swarm/Web/Script
export PATH=$PATH:/Users/seth/Scripts
export PATH=$PATH:/Users/seth/Library/Android/sdk/platform-tools
export PATH=$PATH:/Users/seth/Library/Android/sdk/tools
export PATH=$PATH:$HOME/.yarn/bin
export PATH=$PATH:$HOME/.composer/vendor/bin

# Node version manager
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

if [ -n "$PS1" ]; then
  if ! [ -f ~/.config/base16-shell/profile_helper.sh ]; then
    echo "Missing profile_helper.sh"
  else
    eval "$(~/.config/base16-shell/profile_helper.sh)"
  fi
fi

if [ -n $TMUX ]; then
    cursor_blue
else
    base16_materialdark
    cursor_blue
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
