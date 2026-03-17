# Joy's dotfiles

set shell := ["zsh", "-cu"]
set dotenv-load := false

dotfiles_dir := justfile_directory()

# 全コンポーネントをインストール
install: brew zsh git nvim ghostty zellij tmux starship claude vscode vim karabiner

# Homebrew パッケージ
brew:
    zsh {{dotfiles_dir}}/Brewfile/install.zsh

# Zsh設定 (brewに依存)
zsh: brew
    zsh {{dotfiles_dir}}/zsh/install.zsh

# Git設定
git:
    zsh {{dotfiles_dir}}/git/install.zsh

# Neovim設定
nvim:
    zsh {{dotfiles_dir}}/nvim/install.zsh

# Ghostty設定
ghostty:
    zsh {{dotfiles_dir}}/ghostty/install.zsh

# Zellij設定
zellij:
    zsh {{dotfiles_dir}}/zellij/install.zsh

# Tmux設定
tmux:
    zsh {{dotfiles_dir}}/tmux/install.zsh

# Starship設定
starship:
    zsh {{dotfiles_dir}}/starship/install.zsh

# Claude設定
claude:
    zsh {{dotfiles_dir}}/claude/install.zsh

# VS Code設定
vscode:
    zsh {{dotfiles_dir}}/vscode/install.zsh

# Vim設定
vim:
    zsh {{dotfiles_dir}}/vim/install.zsh

# Karabiner-Elements設定
karabiner:
    zsh {{dotfiles_dir}}/karabiner/install.zsh
