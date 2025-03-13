#!/bin/bash

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo "jq is required but not installed. Please install it first."
    echo "On macOS, you can install it with: brew install jq"
    exit 1
fi

# Read extensions from extensions.json
extensions=$(cat .vscode/extensions.json | jq -r '.recommendations[]')

# Loop through each extension and install it
for extension in $extensions; do
    echo "Installing $extension..."
    code --install-extension "$extension"
done

echo "All extensions have been installed!" 