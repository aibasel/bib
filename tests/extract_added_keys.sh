#!/bin/bash

# Extract keys of all added BibTeX entries from git diff
# Usage: ./extract_added_keys.sh [file]
# If no file specified, checks all .bib files

FILE="${1:-*.bib}"

# Get git diff output
DIFF_OUTPUT=$(git diff "$FILE")

# Extract @Proceedings entries first
PROCEEDINGS=$(echo "$DIFF_OUTPUT" | \
  grep '^+@Proceedings' | \
  sed 's/^+@[^{]*{\([^,]*\),.*$/\1/' | \
  sort -u)

# Then extract all other entry types (excluding @Proceedings)
OTHERS=$(echo "$DIFF_OUTPUT" | \
  grep '^+@[A-Z]' | \
  grep -v '^+@Proceedings' | \
  sed 's/^+@[^{]*{\([^,]*\),.*$/\1/' | \
  sort -u)

# Combine and print comma-separated
echo "$PROCEEDINGS" "$OTHERS" | tr '\n' ',' | sed 's/,$/\n/' | sed 's/^,//'

# Made with Bob
