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

# tmux-worktreeizer's personal config and per-repo hooks (see scripts/README.md).
# Some of what lives there is company code, so it is a separate private repo
# rather than a directory in this one -- cloned straight to ~/.config/tmw, not
# symlinked, since it is its own repo already.
tmw_dir="$HOME/.config/tmw"
tmw_repo="https://github.com/sethawright/tmw-config.git"
if [ -e "$tmw_dir" ] && [ ! -d "$tmw_dir/.git" ]; then
  echo "Moving aside: $tmw_dir -> $tmw_dir.$backup_stamp.bak"
  mv "$tmw_dir" "$tmw_dir.$backup_stamp.bak"
fi
if [ -d "$tmw_dir/.git" ]; then
  echo "Already cloned: $tmw_dir"
elif command -v git >/dev/null 2>&1; then
  echo "Cloning tmw-config -> $tmw_dir"
  git clone --quiet "$tmw_repo" "$tmw_dir" ||
    echo "Could not clone $tmw_repo (no access from this machine?); skipping."
fi
