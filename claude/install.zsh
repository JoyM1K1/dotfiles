#!/usr/bin/env zsh

CURRENT_DIR=${0:a:h}
source "${CURRENT_DIR}/../lib/utils.zsh"

mkdir -p "$HOME/.claude"
safe_link "$CURRENT_DIR/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
safe_link "$CURRENT_DIR/settings.json" "$HOME/.claude/settings.json"
