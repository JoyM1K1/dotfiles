#!/usr/bin/env zsh

# 自作スキルだけをリンクする。既存の外部スキルには触れない。
link_personal_skills() {
    emulate -L zsh
    local source_dir=${1:A}
    shift
    local target_dir skill dst link
    local -a skills=("$source_dir"/*/SKILL.md(N))

    # 全配置先を先に検査し、同名の外部スキルがあれば変更前に停止する。
    for target_dir in "$@"; do
        for skill in "${skills[@]}"; do
            dst="$target_dir/${${skill:h}:t}"
            if [[ -e "$dst" || -L "$dst" ]]; then
                if [[ ! -L "$dst" || "${dst:A}" != "${skill:h:A}" ]]; then
                    print -u2 -r -- "既存スキルと競合しています: $dst"
                    return 1
                fi
            fi
        done
    done
    for target_dir in "$@"; do
        mkdir -p -- "$target_dir" || return 1
        for skill in "${skills[@]}"; do
            dst="$target_dir/${${skill:h}:t}"
            [[ -L "$dst" ]] && continue
            ln -s -- "${skill:h}" "$dst" || return 1
            print -r -- "リンク: $dst -> ${skill:h}"
        done
        # この原本を指すリンクだけを掃除し、自作スキルの削除にも追従する。
        for dst in "$target_dir"/*(N@); do
            link=$(readlink "$dst") || return 1
            if [[ "$link" == "$source_dir/${dst:t}" && ! -f "$link/SKILL.md" ]]; then
                rm -- "$dst" || return 1
                print -r -- "削除済みスキルのリンクを解除: $dst"
            fi
        done
    done
    return 0
}
