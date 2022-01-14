#!/usr/bin/env zsh

CURRENT_DIR=${0:a:h}
INSTALL_FILENAME="Brewfile${BREWFILE_SUFFIX:+".${BREWFILE_SUFFIX}"}"

brew bundle --file "${CURRENT_DIR}/${INSTALL_FILENAME}"
