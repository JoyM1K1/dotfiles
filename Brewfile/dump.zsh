#!/usr/bin/env zsh

CURRENT_DIR=${0:a:h}
DUMP_FILENAME="Brewfile${BREWFILE_SUFFIX:+".${BREWFILE_SUFFIX}"}"

brew bundle dump --force --file "${CURRENT_DIR}/${DUMP_FILENAME}"
