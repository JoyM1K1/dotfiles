#!/usr/bin/env zsh

set -eu

DOTFILES_REPO="JoyM1K1/dotfiles"
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"

echo "\e[34;1m==> dotfiles bootstrap\e[0m"

# 1. Xcode Command Line Tools
if ! xcode-select -p &>/dev/null; then
    echo "\e[34;1m==> Xcode Command Line Tools をインストール中...\e[0m"
    xcode-select --install
    echo "インストール完了後、このスクリプトを再実行してください。"
    exit 0
fi

# 2. Homebrew
if ! command -v brew &>/dev/null; then
    echo "\e[34;1m==> Homebrew をインストール中...\e[0m"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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
