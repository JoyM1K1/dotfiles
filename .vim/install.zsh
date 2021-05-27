#!/usr/bin/env zsh
CURRENT_DIR=${0:a:h}

zsh $CURRENT_DIR/dein_installer.sh $CURRENT_DIR/bundles

ln -s "$CURRENT_DIR" "~"