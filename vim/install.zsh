#!/usr/bin/env zsh
CURRENT_DIR=${0:a:h}

if [[ ! -d ${CURRENT_DIR}/bundles/repos/github.com/Shougo/dein.vim ]]; then
    if [[ ! -f "${CURRENT_DIR}/dein_installer.sh" ]]; then
        curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > "${CURRENT_DIR}/dein_installer.sh"
    fi
    zsh "${CURRENT_DIR}/dein_installer.sh" "${CURRENT_DIR}/bundles"
fi

ln -ins "${CURRENT_DIR}" ~/.vim
