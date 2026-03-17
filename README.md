# Joy's dotfiles

## 新規マシン

```sh
curl -fsSL https://raw.githubusercontent.com/JoyM1K1/dotfiles/main/bootstrap.zsh | zsh
```

## 既存マシン

```sh
gh repo clone JoyM1K1/dotfiles -- --recursive
cd dotfiles
just install
```

## コマンド

```sh
just install        # 全コンポーネントをインストール
just zsh            # 個別インストール
just -n install     # dry-run (何が実行されるか確認)
just -l             # レシピ一覧
```
