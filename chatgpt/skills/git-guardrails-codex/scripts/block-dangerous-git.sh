#!/usr/bin/env bash

INPUT=$(cat)
COMMAND=$(printf '%s' "$INPUT" | jq -r '.tool_input.command // ""')

DANGEROUS_PATTERNS=(
  "git push"
  "git reset --hard"
  "git clean [^;&|]*-[^ ]*f"
  "git branch -D"
  "git checkout \."
  "git restore \."
  "push --force"
  "reset --hard"
)

for pattern in "${DANGEROUS_PATTERNS[@]}"; do
  if echo "$COMMAND" | grep -qE "$pattern"; then
    echo "BLOCKED: '$COMMAND' matches configured destructive Git pattern '$pattern'." >&2
    exit 2
  fi
done

exit 0
