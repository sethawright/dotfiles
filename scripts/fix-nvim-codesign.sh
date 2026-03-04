#!/bin/bash

set -eo pipefail

echo "Re-signing treesitter parser .so files..."

count=0
for f in \
	"$HOME/.local/share/nvim/site/parser"/*.so \
	/opt/homebrew/Cellar/neovim/*/lib/nvim/parser/*.so; do
	[ -f "$f" ] || continue
	codesign --force --sign - "$f" 2>/dev/null
	count=$((count + 1))
done

echo "Re-signed $count parser(s)."
