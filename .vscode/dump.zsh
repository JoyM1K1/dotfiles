#!/usr/bin/env zsh

DOTVSCODEDIR=${0:a:h}
code --list-extensions > "${DOTVSCODEDIR}/extensions"