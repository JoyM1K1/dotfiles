#!/bin/zsh
setopt EXTENDED_GLOB

for rcfile in ${ZDOTDIR:-$HOME}/.zprezto/runcoms/^README.md(.N); do
    dot_rcfile="${ZDOTDIR:-$HOME}/.${rcfile:t}"
    rcfile_override="${ZDOTDIR:-$HOME}/.zprezto_override/${rcfile:t}"
    if [[ -f $dot_rcfile ]]; then
        echo "replace symbolic link : $dot_rcfile"
        rm -f $dot_rcfile
    fi
    if [[ -f $rcfile_override ]]; then
        ln -s "$rcfile_override" "$dot_rcfile"
    else
        ln -s "$rcfile" "$dot_rcfile"
    fi
done