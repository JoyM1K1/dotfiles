#!/usr/bin/env zsh

CURRENT_DIR=${0:a:h}
INSTALL_FILENAME="Brewfile${BREWFILE_SUFFIX:+".${BREWFILE_SUFFIX}"}"

# ダウンロードが Connection reset 等で失敗してもリトライする
export HOMEBREW_CURL_RETRIES=3

# brew bundle はフェッチ段階で1件でも失敗すると全体が中断し、何もインストールされない。
# 一時的なネットワーク断から回復できるよう数回リトライする (インストール済みはスキップされる)。
typeset -i attempts=3 i
for (( i = 1; i <= attempts; i++ )); do
    if brew bundle --file "${CURRENT_DIR}/${INSTALL_FILENAME}"; then
        break
    fi
    if (( i == attempts )); then
        echo >&2 "\e[31;1mbrew bundle が ${attempts} 回失敗しました。\e[0m"
        exit 1
    fi
    echo >&2 "\e[33;1mbrew bundle 失敗。再試行します (${i}/${attempts})...\e[0m"
    sleep 5
done

# completionを読み込ませるために必要
chmod -R go-w /opt/homebrew/share
