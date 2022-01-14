#!/usr/bin/env zsh

DOT_VSCODE_DIR=${0:a:h}
EXTENSIONS_FILENAME=${1:-extensions}

VSCODE_SETTING_DIR=$HOME/Library/Application\ Support/Code/User

files=("settings.json" "keybindings.json")
for file in $files; do
    if [[ -f $VSCODE_SETTING_DIR/$file ]]; then
        echo "replace settings.json with symbolic link"
        rm -f "$VSCODE_SETTING_DIR/$file"
    fi
    ln -s "$DOT_VSCODE_DIR/$file" "$VSCODE_SETTING_DIR/$file"
done

# extensions
cat "${DOT_VSCODE_DIR}/${EXTENSIONS_FILENAME}" | while read line
do
    code --install-extension $line
done
