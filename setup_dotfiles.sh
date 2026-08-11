#!/bin/bash

# Symlink config directories out of this repo. Safe to re-run: links that
# already point at the right place are left alone, and anything real that is
# in the way gets moved aside rather than destroyed.

set -u

dotfiles_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
backup_stamp="$(date +%Y%m%d%H%M%S)"

# each becomes ~/.config/<name>
dirs=(
  "alacritty"
  "fish"
  "nvim"
  "tmux"
  "ghostty"
  "zed"
  "mise"
)

link() {
  local source="$1"
  local target="$2"

  if [ ! -e "$source" ]; then
    echo "Skipping $target: $source does not exist"
    return
  fi

  if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
    echo "Already linked: $target"
    return
  fi

  # a real file or directory here would be lost when the link replaces it
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    echo "Moving aside: $target -> $target.$backup_stamp.bak"
    mv "$target" "$target.$backup_stamp.bak"
  fi

  mkdir -p "$(dirname "$target")"
  ln -sfn "$source" "$target"
  echo "Linked: $target -> $source"
}

for dir in "${dirs[@]}"; do
  link "$dotfiles_dir/$dir" "$HOME/.config/$dir"
done

link "$dotfiles_dir/lazygit/config.yml" "$HOME/Library/Application Support/lazygit/config.yml"
