#!/usr/bin/env zsh

set -eu

CURRENT_DIR=${0:a:h}
source "${CURRENT_DIR}/../lib/utils.zsh"

zsh "$CURRENT_DIR/../agents/install.zsh"
mkdir -p "$HOME/.claude"
safe_link "$CURRENT_DIR/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
safe_link "$CURRENT_DIR/settings.json" "$HOME/.claude/settings.json"
