#!/bin/bash

# Fetch the latest changes from remote
git fetch

# Get current branch
current_branch=$(git branch --show-current)

# List all branches that have been merged to main
merged_branches=$(git branch --merged origin/main | grep -v "^\*" | grep -v "main" | tr -d ' ')

# Check if there are any merged branches
if [ -z "$merged_branches" ]; then
  echo "No merged branches found."
  exit 0
fi

echo "The following branches will be deleted:"
echo "$merged_branches"
echo ""
read -p "Do you want to continue? (y/n): " confirm

if [ "$confirm" != "y" ]; then
  echo "Operation cancelled."
  exit 0
fi

# Delete each merged branch
for branch in $merged_branches; do
  # Skip current branch
  if [ "$branch" = "$current_branch" ]; then
    echo "Skipping current branch: $branch"
    continue
  fi

  # Delete the branch
  git branch -d "$branch"
  echo "Deleted branch: $branch"
done

echo "All merged branches have been deleted."
