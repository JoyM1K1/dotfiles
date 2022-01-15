#!/usr/bin/env zsh

setopt EXTENDED_GLOB

CURRENT_DIR=${0:a:h}

# HOMEのzshenvを置き換える
ln -is "${CURRENT_DIR}/.zprezto_override/zshenv_global" "${HOME}/.zshenv"
if [[ $? -ne 0 ]]; then
    echo >&2 "\e[31;1mExit installation.\e[0m"
    exit 1
fi
source "${HOME}/.zshenv"

local z_dot_dir=${ZDOTDIR:-$HOME}

for default_rcfile in "${z_dot_dir}"/.zprezto/runcoms/^README.md(.N); do
    local dot_rcfile="${z_dot_dir}/.${default_rcfile:t}"
    local custom_rcfile=${z_dot_dir}/.zprezto_override/${default_rcfile:t}
    local rcfile=$default_rcfile
    if [[ -f $custom_rcfile ]]; then
        # .zprezto_override 配下にrcfileがあれば使う
        rcfile=$custom_rcfile
    fi
    if [[ -f $dot_rcfile ]]; then
        ln -is "$rcfile" "$dot_rcfile"
    else
        ln -fs "$rcfile" "$dot_rcfile"
    fi
done
