echo "Running mac setup! Grab a coffee."

# brew
if test ! "$(command -v brew)"; then
	echo "Installing Homebrew"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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
brew install --cask 1password-cli
brew install --cask alacritty
brew install --cask docker
brew install --cask firefox
brew install --cask font-sf-mono-nerd-font
brew install --cask font-sf-mono-nerd-font-ligaturized
brew install --cask github
brew install --cask google-chrome
brew install --cask jetbrains-toolbox
brew install --cask postman
brew install --cask proxyman
brew install --cask raycast
brew install --cask sf-symbols
brew install --cask tableplus
brew install --cask topnotch
brew install --cask visual-studio-code
brew install --cask zoom

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

mkdir -p ~/.ssh && cd ~/.ssh
touch config
chmod 600 config

# macos preferences
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 12
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
chflags nohidden ~/Library
defaults write com.apple.dock static-only -bool true
defaults write com.apple.dock showhidden -bool true
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock show-process-indicators -bool false
defaults write com.apple.dock autohide -bool true
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
defaults write com.apple.Safari AutoFillFromAddressBook -bool false
defaults write com.apple.Safari AutoFillPasswords -bool false
defaults write com.apple.Safari AutoFillCreditCardData -bool false
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false

brew cleanup

gh auth login

echo "1. Set up and sign in to 1password"
echo "2. Set up 1password ssh agent"
echo "3. Set up 1password ssh agent"
