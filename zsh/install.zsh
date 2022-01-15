#!/usr/bin/env zsh
setopt EXTENDED_GLOB

for default_rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    local dot_rcfile="${ZDOTDIR:-$HOME}/.${default_rcfile:t}"
    local custom_rcfile=${ZDOTDIR:-$HOME}/.zprezto_override/${default_rcfile:t}
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
