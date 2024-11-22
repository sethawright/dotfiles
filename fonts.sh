#!/bin/bash

docker run --rm -v ~/dotfiles/sf-mono-original:/in -v ~/dotfiles/sf-mono-patched:/out nerdfonts/patcher --complete

echo "Available Monospace Fonts:"
echo "-------------------------"
fc-list :spacing=mono:scalable=true -f "%{family[0]}: %{style[0]}\n" |
  grep -i "regular" |
  sort |
  uniq |
  while IFS=':' read -r family style; do
    printf "Family: %-30s Style: %s\n" "$family" "$style"
  done
