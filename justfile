# Joy's dotfiles

set shell := ["zsh", "-cu"]
set dotenv-load := false

dotfiles_dir := justfile_directory()

# 全コンポーネントをインストール
install: brew zsh git nvim ghostty zellij agents claude codex vscode vim karabiner

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

# Claude設定
claude: agents
    zsh {{dotfiles_dir}}/claude/install.zsh

# 自作スキルを Claude / Codex で共有
agents:
    zsh "{{dotfiles_dir}}/agents/install.zsh"

# Codex の自作スキル (設定・外部スキルは各ツールで管理)
codex: agents

# VS Code設定
vscode:
    zsh {{dotfiles_dir}}/vscode/install.zsh

# Vim設定
vim:
    zsh {{dotfiles_dir}}/vim/install.zsh

# Karabiner-Elements設定
karabiner:
    zsh {{dotfiles_dir}}/karabiner/install.zsh
