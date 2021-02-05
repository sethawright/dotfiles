KEYTIMEOUT=1
ZSH_DISABLE_COMPFIX="true"

export ZSH=/Users/seth/.oh-my-zsh
plugins=( colorize tmux )
source $ZSH/oh-my-zsh.sh

alias puf='vendor/bin/phpunit --filter '
alias pu='vendor/bin/phpunit'
alias puf='vendor/bin/phpunit --filter '
alias todo='vim -c "set norelativenumber nonumber laststatus=0" -c "VimwikiIndex"'
alias org='vim -c "set norelativenumber nonumber laststatus=0" -c "VimwikiIndex"'
alias today='vim -c "set norelativenumber nonumber wrap textwidth=0 nocp linebreak nolist showbreak= laststatus=0" -c "VimwikiDiaryIndex"'
alias firefox='open -a firefox'
alias preview='open -a Preview'
alias chrome='open -a Google\ Chrome'
alias safari='open -a Safari'
alias mail='neomutt'
alias mutt='neomutt'
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
alias compress="ffmpeg -filter_complex 'scale=-1:720' -vcodec libx264 -preset medium -crf 26 -acodec libfdk_aac -b:a 96k -pix_fmt yuv420p -y output.mp4 -i"
alias thumbnail="ffmpeg -pix_fmt yuvj422p -ss 1 -vframes 1 -q:v 2 -y output.jpg -i"
alias linux='ssh linux'
alias timestamp='date +"%Y-%m-%d %H:%M:%S"'
alias wstart="watson start"
alias wstop="watson stop"
alias wstatus="watson status | sed \"s/Project//\" | sed -e \"s/ (.*//\""
alias c="code ."
alias v="nvim"
alias e="nvim"
alias m="nvim"
alias s="subl ."
alias getdb="rsync -avz --stats --progress swarmint:/home/swarmint/backup/swarmint_vm-$(date -v-1d +%Y-%m-%d).sql.gz ~/Sites/work/backup/dbs/"
alias getjoomdb="rsync -avz --stats --progress swarmint:/home/swarmint/backup/swarmint_joom3-$(date -v-1d +%Y-%m-%d).sql.gz ~/Sites/work/backup/dbs/"
alias getlog="rsync -avz --stats --progress swarmint:/home/swarmint/www/storage/logs/$(date +%Y-%m-%d).log ~/Sites/work/backup/logs/ && vim ~/Sites/work/backup/logs/$(date +%Y-%m-%d).log"
alias adbpic='adb shell screencap -p | perl -pe "s/\x0D\x0A/\x0A/g" > "/Users/seth/Downloads/firetvscreenshot_$(date +%Y%m%d-%H%M%S).png"'
alias firetv='adb kill-server && adb start-server && adb connect 192.168.0.99'
alias x96='adb kill-server && adb start-server && adb connect 192.168.0.98'
alias env_old='valet stop && cd ~/sites/work/web && vagrant up && open https://old.swarm.test/vm/'
alias env_new='cd ~/sites/work/web && vagrant halt && valet start && open https://swarm.test/'

# quick theme switching
alias digim='viewmedica-content-packager -C 7802 --video --thumbnails --vtt --csv --srt --language es ~/Desktop/digim'
alias darker='ln -sf ~/dotfiles/materitermdarkmode.sh ~/.base16_theme  && . ~/.base16_theme'
alias material='ln -sf ~/dotfiles/materitermdark.sh ~/.base16_theme  && . ~/.base16_theme'
alias pale='ln -sf ~/dotfiles/materitermpale.sh ~/.base16_theme  && . ~/.base16_theme'
alias ocean='ln -sf ~/dotfiles/materitermocean.sh ~/.base16_theme  && . ~/.base16_theme'
alias lighter='ln -sf ~/dotfiles/materitermlighter.sh ~/.base16_theme  && . ~/.base16_theme'
alias light='ln -sf ~/dotfiles/materitermlight.sh ~/.base16_theme  && . ~/.base16_theme'
alias minlight='ln -sf ~/dotfiles/minlight.sh ~/.base16_theme  && . ~/.base16_theme'
alias mindark='ln -sf ~/dotfiles/mindark.sh ~/.base16_theme  && . ~/.base16_theme'
alias monokaipro='ln -sf ~/dotfiles/monokaipro.sh ~/.base16_theme  && . ~/.base16_theme'
alias monokaioctagon='ln -sf ~/dotfiles/monokaioctagon.sh ~/.base16_theme  && . ~/.base16_theme'
alias monokaimachine='ln -sf ~/dotfiles/monokaimachine.sh ~/.base16_theme  && . ~/.base16_theme'
alias monokairistretto='ln -sf ~/dotfiles/monokairistretto.sh ~/.base16_theme  && . ~/.base16_theme'
alias monokaispectrum='ln -sf ~/dotfiles/monokaispectrum.sh ~/.base16_theme  && . ~/.base16_theme'
alias dracula='ln -sf ~/dotfiles/dracula.sh ~/.base16_theme && . ~/.base16_theme'
alias gruvbox='ln -sf ~/dotfiles/gruvbox.sh ~/.base16_theme && . ~/.base16_theme'
alias gruvbox-light='ln -sf ~/dotfiles/gruvbox-light.sh ~/.base16_theme && . ~/.base16_theme'
alias github='ln -sf ~/dotfiles/github.sh ~/.base16_theme && . ~/.base16_theme'

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

alias work="tmux new-session -A -s work"
alias endwork="tmux kill-session -t work"
alias maketags="find . -type f -iregex \".*\.js$\" -not -path \"./node_modules/*\" -exec jsctags {} -f \; | sed '/^$/d' | sort > tags"
alias ctags="/usr/local/bin/ctags"
alias seth_status="WATSON_DIR=~/Dropbox/Watson/Seth watson status"
alias andrew_status="WATSON_DIR=~/Dropbox/Watson/Andrew watson status"
alias seth_log="WATSON_DIR=~/Dropbox/Watson/Seth watson log"
alias andrew_log="WATSON_DIR=~/Dropbox/Watson/Andrew watson log"
alias seth_report="WATSON_DIR=~/Dropbox/Watson/Seth watson report"
alias andrew_report="WATSON_DIR=~/Dropbox/Watson/Andrew watson report"

export EDITOR='vim'
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# set path
export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/opt/ruby/bin:/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/lib/ruby/gems/2.6.0/bin:$PATH
export PATH=$PATH:/users/seth/dropbox/swarm/web/script
export PATH=$PATH:/Users/seth/Documents/Scripts
export PATH=$PATH:/Users/seth/Library/Android/sdk
export PATH=$PATH:/Users/seth/Library/Android/sdk/platform-tools
export PATH=$PATH:/Users/seth/Library/Android/sdk/tools
export PATH=$PATH:$HOME/.yarn/bin
export PATH=$PATH:$HOME/.composer/vendor/bin
export PATH=$PATH:vendor/bin
export PATH=$PATH:node_modules/.bin

export ANDROID_HOME=/Users/seth/Library/Android/sdk
export ANDROID_SDK_ROOT=/Users/seth/Library/Android/sdk

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

autoload -U promptinit; promptinit
prompt pure

###-tns-completion-start-###
if [ -f /Users/seth/.tnsrc ]; then
    source /Users/seth/.tnsrc
fi
###-tns-completion-end-###

###-tns-completion-start-###
if [ -f /Users/seth/.tnsrc ]; then
    source /Users/seth/.tnsrc
fi
###-tns-completion-end-###
