#!/usr/bin/env zsh

DOTVSCODEDIR=${0:a:h}
VSCODE_SETTING_DIR=$HOME/Library/Application\ Support/Code\ -\ Insiders/User

files=("settings.json" "keybindings.json")
for file in $files; do
    if [[ -f $VSCODE_SETTING_DIR/$file ]]; then
        echo "replace settings.json with symbolic link"
        rm -f "$VSCODE_SETTING_DIR/$file"
    fi
    ln -s "$DOTVSCODEDIR/$file" "$VSCODE_SETTING_DIR/$file"
done

# extensions
cat extensions | while read line
do
    code --install-extension $line
done
code --list-extensions > extensions
