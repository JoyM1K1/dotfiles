#!/usr/bin/env zsh

# ログ出力
log_info() { echo "\e[34;1m[INFO]\e[0m $1" }
log_ok()   { echo "\e[32;1m[OK]\e[0m $1" }
log_err()  { echo "\e[31;1m[ERR]\e[0m $1" >&2 }

# シンボリックリンクを安全に作成する
# - 正しいリンクが既にあればスキップ
# - シンボリックリンクだが別のリンク先 → 上書き
# - 実ファイル/ディレクトリ → 対話確認
safe_link() {
    local src=$1 dst=$2
    if [[ -L "$dst" ]]; then
        if [[ "$(readlink "$dst")" == "$src" ]]; then
            return 0
        fi
        ln -sfn "$src" "$dst"
    elif [[ -e "$dst" ]]; then
        echo "既存ファイルがあります: $dst"
        if [[ -d "$dst" ]]; then
            # ln は実ディレクトリを dst にすると「その中」にリンクを作ってしまい
            # -i の確認も効かないため、退避を自前で確認して行う
            local bak="${dst}.bak" i=1
            while [[ -e "$bak" ]]; do
                bak="${dst}.bak.${i}"
                (( i++ ))
            done
            if ! read -q "?置き換えますか? (既存は ${bak} へ退避) [y/N] "; then
                echo
                log_info "スキップ: $dst"
                return 1
            fi
            echo
            mv "$dst" "$bak" || return 1
            log_info "退避しました: $bak"
        fi
        ln -isn "$src" "$dst"
    else
        ln -sn "$src" "$dst"
    fi
}
