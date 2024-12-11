#!/bin/bash

# Define array of directories
dirs=(
  "alacritty"
  "fish"
  "nvim"
  "tmux"
  "wezterm"
)

# Create ~/.config if it doesn't exist
mkdir -p ~/.config

# Loop through each directory and create symbolic links
for dir in "${dirs[@]}"; do
  target=~/.config/"$dir"
  source=~/dotfiles/"$dir"

  # First verify the source exists
  if [ ! -d "$source" ]; then
    echo "Error: Source directory $source does not exist. Skipping..."
    continue
  fi

  # Handle existing target
  if [ -L "$target" ]; then
    echo "Removing existing symlink: $target"
    unlink "$target"
  elif [ -e "$target" ]; then
    echo "Warning: $target exists and is not a symlink. Skipping..."
    continue
  fi

  # Create symbolic link
  echo "Creating symlink: $source -> $target"
  ln -s "$source" "$target"
done
