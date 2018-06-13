KEYTIMEOUT=1

export ZSH=/Users/seth/.oh-my-zsh
plugins=(
  colorize
)
source $ZSH/oh-my-zsh.sh

autoload -U promptinit; promptinit
prompt pure

alias todo='vim -c "set norelativenumber nonumber laststatus=0" -c "VimwikiIndex"'
alias org='vim -c "set norelativenumber nonumber laststatus=0" -c "VimwikiIndex"'
alias today='vim -c "set norelativenumber nonumber wrap textwidth=0 nocp linebreak nolist showbreak= laststatus=0" -c "VimwikiMakeDiaryNote"'
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
alias swarmint='ssh swarmint'
alias swarmqs='ssh swarmqs'
alias swarm='ssh swarm'
alias backup='ssh swarmback'
alias gridserver='ssh seth'
alias staging='ssh staging'
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
alias wstart="watson start"
alias wstop="watson stop"
alias v="vim"
alias e="vim"
alias m="mvim"
alias s="subl ."
alias getdb="rsync -avz --stats --progress swarmint:/home/swarmint/backup/swarmint_vm-$(date -v-1d +%Y-%m-%d).sql.gz ~/Documents/backup/dbs/"
alias getjoomdb="rsync -avz --stats --progress swarmint:/home/swarmint/backup/swarmint_joom3-$(date -v-1d +%Y-%m-%d).sql.gz ~/Documents/backup/"
alias getlog="rsync -avz --stats --progress swarmint:/home/swarmint/www/storage/logs/$(date +%Y-%m-%d).log ~/Documents/backup/logs/ && vim ~/Documents/backup/logs/$(date +%Y-%m-%d).log"
alias adbpic='adb shell screencap -p | perl -pe "s/\x0D\x0A/\x0A/g" > "/Users/seth/Downloads/firetvscreenshot_$(date +%Y%m%d-%H%M%S).png"'
alias firetv='adb kill-server && adb start-server && adb connect 192.168.0.99'
alias x96='adb kill-server && adb start-server && adb connect 192.168.0.98'

# quick theme switching
alias dark='ln -sf ~/dotfiles/materitermdark.sh ~/.zsh_theme  && . ~/.zsh_theme'
alias pale='ln -sf ~/dotfiles/materitermpale.sh ~/.zsh_theme  && . ~/.zsh_theme'
alias light='ln -sf ~/dotfiles/materitermlight.sh ~/.zsh_theme  && . ~/.zsh_theme'
alias nord='ln -sf ~/dotfiles/nord.sh ~/.zsh_theme && . ~/.zsh_theme'

# git stuff
alias ga="gg a"
alias gac="gg c"
alias gc="gg cn"
alias gco="git checkout"
alias gd="git difftool"
alias gs="gg s"
alias gl="gg l"
alias gp="gg p"
alias gpl="gg pl"
alias fireclear="adb shell pm clear com.viewmedica.firetv.dev"

alias work="tmuxinator start work"
alias endwork="tmuxinator stop work"
alias maketags="find . -type f -iregex \".*\.js$\" -not -path \"./node_modules/*\" -exec jsctags {} -f \; | sed '/^$/d' | sort > tags"
alias ctags="/usr/local/bin/ctags"
alias seth_status="WATSON_DIR=~/Dropbox/Watson/Seth watson status"
alias andrew_status="WATSON_DIR=~/Dropbox/Watson/Andrew watson status"
alias seth_log="WATSON_DIR=~/Dropbox/Watson/Seth watson log"
alias andrew_log="WATSON_DIR=~/Dropbox/Watson/Andrew watson log"
alias seth_report="WATSON_DIR=~/Dropbox/Watson/Seth watson report"
alias andrew_report="WATSON_DIR=~/Dropbox/Watson/Andrew watson report"

# set path
export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:$PATH
export PATH=$PATH:/users/seth/dropbox/swarm/web/script
export PATH=$PATH:/Users/seth/Scripts
export PATH=$PATH:/Users/seth/Library/Android/sdk
export PATH=$PATH:/Users/seth/Library/Android/sdk/platform-tools
export PATH=$PATH:/Users/seth/Library/Android/sdk/tools
export PATH=$PATH:$HOME/.yarn/bin
export PATH=$PATH:$HOME/.composer/vendor/bin

export EDITOR='vim'
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export WATSON_DIR=~/Dropbox/Watson/Seth/

if [[ -f ~/.zsh_theme ]]; then
  . ~/.zsh_theme
fi

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
