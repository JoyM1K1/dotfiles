#!/usr/bin/env zsh

setopt EXTENDED_GLOB

CURRENT_DIR=${0:a:h}
source "${CURRENT_DIR}/../lib/utils.zsh"

# HOMEのzshenvを置き換える
safe_link "${CURRENT_DIR}/.zprezto_override/zshenv_global" "${HOME}/.zshenv"
if [[ $? -ne 0 ]]; then
    echo >&2 "\e[31;1mExit installation.\e[0m"
    exit 1
fi
source "${HOME}/.zshenv"

local z_dot_dir=${ZDOTDIR:-$HOME}

# rcfileのシンボリックリンクを作成
for rcname in zshenv zshrc zprofile zlogin zlogout; do
    safe_link "${CURRENT_DIR}/.zprezto_override/${rcname}" "${z_dot_dir}/.${rcname}"
done

# completion download
local -A rc_url_list
rc_url_list=(
	_task "https://raw.githubusercontent.com/go-task/task/main/completion/zsh/_task"
)

for key in ${(k)rc_url_list}; do
	curl -o "${CURRENT_DIR}/functions/${key}" "${rc_url_list[$key]}"
done
