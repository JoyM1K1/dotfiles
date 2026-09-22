# Joy's dotfiles

## 新規マシン

```sh
zsh -c "$(curl -fsSL https://raw.githubusercontent.com/JoyM1K1/dotfiles/main/bootstrap.zsh)"
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

## Claude / Codex の自作スキル

dotfiles で管理・共有するスキルは自作のものだけ。
原本を `agents/skills/` に置き、次のコマンドで両方のツールへリンクする。

```sh
just agents
```

```text
~/.agents/skills/<自作スキル> → dotfiles/agents/skills/<自作スキル>
~/.claude/skills/<自作スキル> → dotfiles/agents/skills/<自作スキル>
```

インストーラーは `SKILL.md` を持つフォルダを自動検出する。
スキル名の列挙は不要で、追加・削除後に再実行すればリンクが更新される。
同名の外部スキルがある場合は、変更前に停止する。再実行しても同じリンクは作り直さない。
Git 管理対象は `agents/.gitignore` の許可リストで指定する。

Cloudflare などの外部スキル・プラグインは、各配布元の推奨手順で導入・更新する。
`~/.codex`・`~/.agents`・`~/.claude/skills` 全体の移動やリンク置き換えは行わず、
外部スキル、設定、認証情報、履歴、DB に触れない。
以前の `just migrate-agents` / `just check-agent-migration` は廃止した。
アプリ終了を伴う一括移行は不要。

自作の Claude 専用スキル `agpair`・`pre-compact` は `claude-marketplace/` に置く。
共有化した `joy-docs`・`joy-git` プラグインは Claude 設定で無効にしている。
Claude の既存 `joy-claude` キャッシュに旧 `skill-builder` が残っている場合は、
プラグインを更新して共有スキルとの重複を解消する。

`just codex` も自作スキルの設定を実行する。
`just claude` はそれに加えて、従来の `CLAUDE.md` と `settings.json` をリンクする。
インストーラーの検証: `zsh agents/test_install.zsh`
