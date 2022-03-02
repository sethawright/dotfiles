alias l="ls -lah"
alias puf='vendor/bin/phpunit --filter '
alias pu='vendor/bin/phpunit test'

alias firefox='open -a firefox'
alias preview='open -a Preview'
alias chrome='open -a Google\ Chrome'
alias safari='open -a Safari'
alias finder='open -a Finder'
alias tmsize='tmux detach -a'
alias swarmint='ssh swarmint'
alias swarmqs='ssh swarmqs'
alias swarm='ssh swarm'
alias backup='ssh swarmback'
alias gridserver='ssh seth'
alias staging='ssh staging'
alias redesign='ssh redesign@swarm.swarm1.com'
alias mysql5='mysql -S /tmp/mysql_3307.sock'
alias mysqldump5='mysqldump -S /tmp/mysql_3307.sock --column-statistics=0'
alias compress="ffmpeg -filter_complex 'scale=-1:720' -vcodec libx264 -preset medium -crf 26 -acodec libfdk_aac -b:a 96k -pix_fmt yuv420p -y output.mp4 -i"
alias c="code ."
alias v="nvim"
alias e="nvim"
alias vim="nvim"
alias m="nvim"
alias s="subl ."
alias getdb="rsync -avz --stats --progress my:/home/my/snapshots/latest.sql.gz ~/Desktop && gunzip ~/Desktop/latest.sql.gz && mysql -u root -proot -e 'drop database cms; create database cms; use cms; source ~/Desktop/latest.sql;' && rm -f ~/Desktop/latest.sql"
alias getjoomdb="rsync -avz --stats --progress swarmint:/home/swarmint/backup/swarmint_joom3-(date -v-1d +%Y-%m-%d).sql.gz ~/Sites/work/backup/dbs/"
alias getlog="rsync -avz --stats --progress swarmint:/home/swarmint/www/storage/logs/(date +%Y-%m-%d).log ~/Sites/work/backup/logs/ && vim ~/Sites/work/backup/logs/(date +%Y-%m-%d).log"

# quick theme switching
alias digim='viewmedica-content-packager -C 7802 --video --thumbnails --vtt --csv --srt --language es ~/Desktop/digim'
alias darker='ln -sf ~/dotfiles/materitermdarkmode.sh ~/.base16_theme  && eval sh '"'(realpath ~/.base16_theme)'"''
alias material='ln -sf ~/dotfiles/materitermdark.sh ~/.base16_theme && eval sh '"'(realpath ~/.base16_theme)'"''
alias pale='ln -sf ~/dotfiles/materitermpale.sh ~/.base16_theme  && eval sh '"'(realpath ~/.base16_theme)'"''
alias ocean='ln -sf ~/dotfiles/materitermocean.sh ~/.base16_theme  && eval sh '"'(realpath ~/.base16_theme)'"''
alias lighter='ln -sf ~/dotfiles/materitermlighter.sh ~/.base16_theme  && eval sh '"'(realpath ~/.base16_theme)'"''
alias light='ln -sf ~/dotfiles/materitermlight.sh ~/.base16_theme  && eval sh '"'(realpath ~/.base16_theme)'"''
alias minlight='ln -sf ~/dotfiles/minlight.sh ~/.base16_theme  && eval sh '"'(realpath ~/.base16_theme)'"''
alias mindark='ln -sf ~/dotfiles/mindark.sh ~/.base16_theme  && eval sh '"'(realpath ~/.base16_theme)'"''
alias nord='ln -sf ~/dotfiles/nord.sh ~/.base16_theme  && eval sh '"'(realpath ~/.base16_theme)'"''
alias monokaipro='ln -sf ~/dotfiles/monokaipro.sh ~/.base16_theme  && eval sh '"'(realpath ~/.base16_theme)'"''
alias monokaioctagon='ln -sf ~/dotfiles/monokaioctagon.sh ~/.base16_theme  && eval sh '"'(realpath ~/.base16_theme)'"''
alias monokaimachine='ln -sf ~/dotfiles/monokaimachine.sh ~/.base16_theme  && eval sh '"'(realpath ~/.base16_theme)'"''
alias monokairistretto='ln -sf ~/dotfiles/monokairistretto.sh ~/.base16_theme  && eval sh '"'(realpath ~/.base16_theme)'"''
alias monokaispectrum='ln -sf ~/dotfiles/monokaispectrum.sh ~/.base16_theme  && eval sh '"'(realpath ~/.base16_theme)'"''
alias dracula='ln -sf ~/dotfiles/dracula.sh ~/.base16_theme && eval sh '"'(realpath ~/.base16_theme)'"''
alias gruvbox='ln -sf ~/dotfiles/gruvbox.sh ~/.base16_theme && eval sh '"'(realpath ~/.base16_theme)'"''
alias gruvbox-light='ln -sf ~/dotfiles/gruvbox-light.sh ~/.base16_theme && eval sh '"'(realpath ~/.base16_theme)'"''
alias github='ln -sf ~/dotfiles/github.sh ~/.base16_theme && eval sh '"'(realpath ~/.base16_theme)'"''
alias githubdark='ln -sf ~/dotfiles/githubdark.sh ~/.base16_theme && eval sh '"'(realpath ~/.base16_theme)'"''

alias track='watson start'
alias stop='watson stop'
alias project='watson status'
alias wlog='watson log'
alias wreport='watson report'

function nvim_wrapper
  if test -z $NVIM_LISTEN_ADDRESS
      /usr/local/bin/nvim $argv
  else
    if test -z $argv
        nvr -l -c new
    else
        nvr -l $argv
    end
  end
end
alias nvim="nvim_wrapper"

function wat
    switch $argv[2]
        case seth
            WATSON_DIR=/Users/seth/Library/Mobile\ Documents/com~apple~CloudDocs/Swarm/Seth watson $argv[1] $argv[3..-1]
        case andrew
            WATSON_DIR=/Users/seth/Library/Mobile\ Documents/com~apple~CloudDocs/Swarm/Andrew watson $argv[1] $argv[3..-1]
        case "*"
            WATSON_DIR=/Users/seth/Library/Mobile\ Documents/com~apple~CloudDocs/Swarm/Seth watson $argv[1] $argv[2..-1]
    end
end

function ghpr
  gh pr create --body "Closes swarminteractive/bug-triage\#$argv[1]"
end

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
alias gcl="gh browse -n -c | sed 's/https:\/\/github\.com\///' | sed 's/\/tree\//@/' | sed 's/.\$//' | pbcopy"

alias work="tmux new-session -A -s work"
alias endwork="tmux kill-session -t work"

set -gx EDITOR nvim
set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden --follow --glob "!{node_modules/*,vendor/*,.git/*}"'
set -gx WATSON_DIR '/Users/seth/Library/Mobile Documents/com~apple~CloudDocs/Swarm/Seth'

if status --is-interactive
    set -gx BASE16_SHELL "$HOME/.config/base16-shell/"
    source "$BASE16_SHELL/profile_helper.fish"
end

# set path
set PATH /usr/local/bin /usr/local/sbin /usr/local/opt/ruby/bin /usr/bin /usr/bin /bin /usr/sbin /sbin /opt/X11/bin $PATH
set PATH $PATH /users/seth/dropbox/swarm/web/script
set PATH $PATH /Users/seth/Sites/scripts
set PATH $PATH /Users/seth/Library/Android/sdk
set PATH $PATH /Users/seth/Library/Android/sdk/platform-tools
set PATH $PATH /Users/seth/Library/Android/sdk/tools
set PATH $PATH /Users/seth/.yarn/bin
set PATH $PATH /Users/seth/.composer/vendor/bin
set PATH $PATH vendor/bin
set PATH $PATH node_modules/.bin

set CAPACITOR_ANDROID_STUDIO_PATH "/Users/seth/Applications/JetBrains Toolbox/Android Studio.app"
set ANDROID_HOME /Users/seth/Library/Android/sdk
set ANDROID_SDK_ROOT /Users/seth/Library/Android/sdk
set JAVA_HOME (/usr/libexec/java_home -v 1.8)
