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
set -gx QHOME /Users/sethwright/q

# theming
set DARK_MODE (defaults read -g AppleInterfaceStyle 2> /dev/null)
# set LIGHT_THEME tokyonight-day
# set DARK_THEME tokyonight-night
# set LIGHT_THEME rose-pine-dawn
# set DARK_THEME rose-pine
set LIGHT_THEME github-light
set DARK_THEME github-dark-dimmed
set ALACRITTY_CONFIG_PATH (realpath ~/.config/alacritty/alacritty.toml)

function update_theme
    sed -i '' "s|import = \[.*\]|import = [\"~/.config/alacritty/themes/$argv[1].toml\"]|" $ALACRITTY_CONFIG_PATH
end

function set_theme
    if not set -q AUTO_DARK_MODE
        set -g AUTO_DARK_MODE 1
    end

    if test "$AUTO_DARK_MODE" = 1
        if string match -q $DARK_MODE Dark
            update_theme $DARK_THEME
        else
            update_theme $LIGHT_THEME
        end
    else
        update_theme $argv[1]
    end
end

function theme
    set -g AUTO_DARK_MODE 0
    set_theme $argv[1]
end

set_theme

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
alias cleanup_branches="git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | grep -v '\*' | xargs -r git branch -D"

bind -s -k nul ~/dotfiles/scripts/tmux-sessionizer
alias tms="~/dotfiles/scripts/tmux-sessionizer"

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
