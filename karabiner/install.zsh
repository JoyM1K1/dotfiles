#!/usr/bin/env zsh

CURRENT_DIR=${0:a:h}
source "${CURRENT_DIR}/../lib/utils.zsh"

mkdir -p "$HOME/.config/karabiner"
safe_link "$CURRENT_DIR/karabiner.json" "$HOME/.config/karabiner/karabiner.json"
