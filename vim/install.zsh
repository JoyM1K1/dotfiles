#!/usr/bin/env zsh
CURRENT_DIR=${0:a:h}

if [[ ! -d ${CURRENT_DIR}/bundles/repos/github.com/Shougo/dein.vim ]]; then
    if [[ ! -f "${CURRENT_DIR}/dein_installer.sh" ]]; then
        curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > "${CURRENT_DIR}/dein_installer.sh"
    fi
    zsh "${CURRENT_DIR}/dein_installer.sh" "${CURRENT_DIR}/bundles"
fi

if [[ -d ~/.vim ]]; then
    rm -ir ~/.vim
    if [[ $? -ne 0 ]]; then
        echo >&2 "\e[31;1mExit installation.\e[0m"
        exit 1
    fi
fi

ln -ins "${CURRENT_DIR}" ~/.vim
