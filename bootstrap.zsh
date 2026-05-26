#!/usr/bin/env zsh

set -eu

DOTFILES_REPO="JoyM1K1/dotfiles"
DEFAULT_DIR="$HOME/dotfiles"

echo "\e[34;1m==> dotfiles bootstrap\e[0m"

printf "dotfiles のインストール先 [%s]: " "$DEFAULT_DIR" > /dev/tty
read -r DOTFILES_DIR < /dev/tty
DOTFILES_DIR="${DOTFILES_DIR:-$DEFAULT_DIR}"
DOTFILES_DIR="${DOTFILES_DIR/#\~/$HOME}"  # 先頭の ~ を $HOME に展開 (read では展開されないため)

# ダウンロードが Connection reset 等で失敗してもリトライする
export HOMEBREW_CURL_RETRIES=3

# 1. Xcode Command Line Tools
if ! xcode-select -p &>/dev/null; then
    echo "\e[34;1m==> Xcode Command Line Tools をインストール中...\e[0m"
    xcode-select --install
    echo "インストール完了後、このスクリプトを再実行してください。"
    exit 0
fi

# 2. Homebrew
# 既にインストール済みなら PATH に乗せる (再実行時は paths.d/.zprofile が読まれず
# command -v brew が false になるため、ここで毎回 shellenv を評価しておく)
if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
if ! command -v brew &>/dev/null; then
    echo "\e[34;1m==> Homebrew をインストール中...\e[0m"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" < /dev/tty
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# 3. just
if ! command -v just &>/dev/null; then
    echo "\e[34;1m==> just をインストール中...\e[0m"
    brew install just
fi

# 4. dotfiles リポジトリ
if [[ ! -d "$DOTFILES_DIR" ]]; then
    echo "\e[34;1m==> dotfiles をクローン中...\e[0m"
    if command -v gh &>/dev/null; then
        gh repo clone "$DOTFILES_REPO" "$DOTFILES_DIR" -- --recursive
    else
        git clone --recursive "https://github.com/${DOTFILES_REPO}.git" "$DOTFILES_DIR"
    fi
fi

# 5. インストール実行
cd "$DOTFILES_DIR"
echo "\e[34;1m==> just install を実行中...\e[0m"
just install
