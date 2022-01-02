#!/usr/bin/env zsh

CURRENT_DIR=${0:a:h}

brew bundle dump --force --file "${CURRENT_DIR}/Brewfile"