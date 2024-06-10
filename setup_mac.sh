echo "Running mac setup! Grab a coffee."

# brew
if test ! "$(command -v brew)"; then
	echo "Installing Homebrew"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	(
		echo
		echo 'eval "$(/opt/homebrew/bin/brew shellenv)"'
	) >>/Users/sethwright/.zprofile
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

brew update
brew upgrade

# taps
brew tap homebrew/cask # apps
brew tap epk/epk       # fonts
brew tap shaunsingh/sfmono-nerd-font-ligaturized

# utils
brew install fd
brew install fish
brew install fzf
brew install go
brew install gh
brew install neovim
brew install node
brew install pipx
brew install php
brew install pnpm
brew install postgresql
brew install python
brew install redis
brew install ripgrep
brew install ruby
brew install rust
brew install terraform
brew install tmux
brew install wget
brew install yarn

# apps
brew install --cask 1password
brew install --cask 1password-cli
brew install --cask alacritty
brew install --cask arc
brew install --cask docker
brew install --cask firefox
brew install --cask font-sf-mono-nerd-font
brew install --cask font-sf-mono-nerd-font-ligaturized
brew install --cask github
brew install --cask google-chrome
brew install --cask jetbrains-toolbox
brew install --cask ollama
brew install --cask postman
brew install --cask proxyman
brew install --cask raycast
brew install --cask slack
brew install --cask sf-symbols
brew install --cask tableplus
brew install --cask topnotch
brew install --cask visual-studio-code
brew install --cask warp
brew install --cask zoom

pipx install poetry
npm install -g pnpm
npm install -g n

# git goodies
curl -fsSL git.io/gg.sh | bash

# pause for github login
git clone https://github.com/sethawright/dotfiles.git

mkdir -p ~/.config && cd ~/.config
unlink alacritty
ln -s ~/dotfiles/alacritty/ ./alacritty
unlink fish
ln -s ~/dotfiles/fish/ ./fish
unlink nvim
ln -s ~/dotfiles/nvim/ ./nvim
unlink tmux
ln -s ~/dotfiles/tmux/ ./tmux

cd ~
ln -s ~/dotfiles/gitconfig ./.gitconfig
ln -s ~/dotfiles/gitignore_global ./.gitignore_global

# allow key repeat for vim input
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

mkdir -p ~/.ssh && cd ~/.ssh
touch config
chmod 600 config

brew cleanup

gh auth login

echo "1. Set up and sign in to 1password"
echo "2. Set up 1password ssh agent"
echo "3. Set up 1password ssh agent"
