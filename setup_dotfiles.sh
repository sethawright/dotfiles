#!/bin/bash

# Define array of directories
dirs=(
  "alacritty"
  "fish"
  "nvim"
  "tmux"
  "ghostty"
  "zed"
)

# Create ~/.config if it doesn't exist
mkdir -p ~/.config

# Loop through each directory and create symbolic links
for dir in "${dirs[@]}"; do
    target="$HOME/.config/$dir"
    source="$HOME/dotfiles/$dir"

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

    # Ensure parent directory exists
    mkdir -p "$(dirname "$target")"

    # Create symbolic link
    echo "Creating symlink: $source -> $target"
    ln -s "$source" "$target"
done

