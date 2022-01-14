#!/usr/bin/env zsh

DOT_VSCODE_DIR=${0:a:h}
EXTENSIONS_FILENAME=${1:-extensions}

code --list-extensions > "${DOT_VSCODE_DIR}/${EXTENSIONS_FILENAME}"
