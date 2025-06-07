#!/bin/bash

# Make sure GitHub CLI and jq are installed
if ! command -v gh &>/dev/null || ! command -v jq &>/dev/null; then
  echo "❌ This script requires both GitHub CLI (gh) and jq."
  exit 1
fi

# Fetch latest from origin
git fetch --prune

# Get list of merged PR branch names
echo "📥 Fetching merged PR branches from GitHub..."
merged_branches=$(gh pr list --state merged --limit 1000 --json headRefName | jq -r '.[].headRefName')

# Loop through local branches
echo "🔍 Checking local branches..."
for branch in $(git branch --format="%(refname:short)" | grep -vE '^(main|master)$'); do
  for merged in $merged_branches; do
    if [[ "$branch" == "$merged" ]]; then
      echo "🗑️ Deleting local branch: $branch (merged via squash)"
      git branch -D "$branch"
      break
    fi
  done
done

echo "✅ Done cleaning up squash-merged branches!"
