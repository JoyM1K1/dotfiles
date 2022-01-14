#!/usr/bin/env zsh

DOT_VSCODE_DIR=${0:a:h}
EXTENSIONS_FILENAME=${1:-extensions}

VSCODE_SETTING_DIR=$HOME/Library/Application\ Support/Code/User

files=("settings.json" "keybindings.json")
for file in $files; do
    if [[ -e $VSCODE_SETTING_DIR/$file ]]; then
        ln -is "$DOT_VSCODE_DIR/$file" "$VSCODE_SETTING_DIR/$file"
    else 
        ln -fs "$DOT_VSCODE_DIR/$file" "$VSCODE_SETTING_DIR/$file"
    fi
done

# extensions
cat "${DOT_VSCODE_DIR}/${EXTENSIONS_FILENAME}" | while read line
do
    code --install-extension $line
done
