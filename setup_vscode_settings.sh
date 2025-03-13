#!/bin/bash

defaults write -g ApplePressAndHoldEnabled -bool false

rm -f /Users/sethwright/Library/Application\ Support/Cursor/User/settings.json
ln -s /Users/sethwright/dotfiles/vscode-settings.json /Users/sethwright/Library/Application\ Support/Cursor/User/settings.json

rm -f /Users/sethwright/Library/Application\ Support/Code/User/settings.json
ln -s /Users/sethwright/dotfiles/vscode-settings.json /Users/sethwright/Library/Application\ Support/Code/User/settings.json

rm -f /Users/sethwright/Library/Application\ Support/Cursor/User/keybindings.json
ln -s /Users/sethwright/dotfiles/vscode-keybindings.json /Users/sethwright/Library/Application\ Support/Cursor/User/keybindings.json

rm -f /Users/sethwright/Library/Application\ Support/Code/User/keybindings.json
ln -s /Users/sethwright/dotfiles/vscode-keybindings.json /Users/sethwright/Library/Application\ Support/Code/User/keybindings.json

if ! command -v jq &>/dev/null; then
  echo "jq is required but not installed. Please install it first."
  echo "On macOS, you can install it with: brew install jq"
  exit 1
fi

# Read extensions from extensions.json
extensions=$(cat vscode-extensions.json | jq -r '.recommendations[]')

# Loop through each extension and install it
for extension in $extensions; do
  echo "Installing $extension..."
  code --install-extension "$extension"
  cursor --install-extension "$extension"
done

echo "All extensions have been installed!"
