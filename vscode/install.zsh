#!/usr/bin/env zsh

CURRENT_DIR=${0:a:h}
source "${CURRENT_DIR}/../lib/utils.zsh"

VSCODE_SETTING_DIR=$HOME/Library/Application\ Support/Code/User

files=("settings.json" "keybindings.json")
for file in $files; do
    safe_link "$CURRENT_DIR/$file" "$VSCODE_SETTING_DIR/$file"
done
