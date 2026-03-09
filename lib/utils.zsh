#!/usr/bin/env zsh

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
