#!/usr/bin/env bash

LLM_ASSISTANT="${LLM_ASSISTANT:-codex}"

# Sets the FT for neovim
TEMP_FILE="${TMPDIR:-/tmp}/llm-prompt-$(date +%Y%m%d-%H%M%S)-$$.md"

# Open temp markdown file in your editor
# The editor will block until you save and exit
${EDITOR:-nvim} "$TEMP_FILE"

# Read the content
PROMPT_TEXT=$(cat "$TEMP_FILE")

# Clean up temp file
rm "$TEMP_FILE"

# If the prompt is empty, just run the assistant normally
if [ -z "$PROMPT_TEXT" ]; then
  "$LLM_ASSISTANT" "$@"
else
  # Pass the prompt text to the assistant
  "$LLM_ASSISTANT" "$@" "$PROMPT_TEXT"
fi
