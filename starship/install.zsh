#!/usr/bin/env zsh

CURRENT_DIR=${0:a:h}
source "${CURRENT_DIR}/../lib/utils.zsh"

mkdir -p "${HOME}/.config"
safe_link "${CURRENT_DIR}/starship.toml" "${HOME}/.config/starship.toml"
