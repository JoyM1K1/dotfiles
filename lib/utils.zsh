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
        ln -isn "$src" "$dst"
    else
        ln -sn "$src" "$dst"
    fi
}
