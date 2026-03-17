#!/usr/bin/env zsh

CURRENT_DIR=${0:a:h}

git config --global include.path "${CURRENT_DIR}/.gitconfig_global"
git config --global core.excludesfile "${CURRENT_DIR}/.gitignore_global"
