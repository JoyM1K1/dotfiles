#!/usr/bin/env zsh

CURRENT_DIR=${0:a:h}

for install_file in ${CURRENT_DIR}/*/install.zsh; do
    dir=$install_file:h:t
    echo -n "Install ${dir}? [Y/n] : "
    read input_str
    if [[ -z "$input_str" ]] || [[ "${input_str:0:1:l}" = 'y' ]]; then
        zsh $install_file
        if [[ $? -eq 0 ]]; then
            echo "\e[32;1mInstallation successed!\e[0m🎉"
        fi
    fi
done
