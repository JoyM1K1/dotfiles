---
name: agpair
description: |
  この Claude セッションが動いている herdr の pane の隣に codex を追加し、agmsg monitor で
  双方向に接続する。dotfiles の `agpair add codex` を呼び、出力の AGMSG-DIRECTIVE に従って
  この Claude 側の Monitor も起動する。
  MANDATORY TRIGGERS: /agpair, agpair, codex を追加, codex を隣に起動, codex と疎通, codex を monitor で繋ぐ。
  DO NOT TRIGGER: agmsg の通常のメッセージ送受信 (/agmsg)、codex 単体の起動方法の質問、agpair down の説明。
strict_procedure: true
argument-hint: "[-t TEAM]"
allowed-tools: Bash(agpair *) Monitor
---

# agpair

この Claude が起動している worktree に codex を後から追加し、agmsg monitor で相互接続する。
`agpair up` は claude と codex を両方新規に起動するが、この skill は「claude はもう動いている」前提で
`agpair add codex` を使う。

## Strict procedure profile

- Strictness: strict-procedure。`agpair add codex` の実行と、その出力にある AGMSG-DIRECTIVE への追従が成果そのもの。
- Hard gates: `agpair` が見つからない、または herdr の pane 外 (HERDR_PANE_ID なし) なら、代替手段を試さず停止して報告する。
- Forcing function: AGMSG-DIRECTIVE の Monitor コマンドは一字も変えずそのまま渡す。
- Completion receipt: team 名、codex の pane id、Monitor が起動したか (または既存の watcher が生きていたか) を報告する。

## 手順

1. `agpair add codex $ARGUMENTS` を Bash で実行する。カレントディレクトリが worktree なので `-p` は付けない。
   - 起動済みのこの claude を team に join して delivery mode を monitor にし、右隣の pane に codex を bridge 経由で起動し、bridge が armed になるまで待つ。
   - 数分かかることがある (codex 起動 + bridge 待ち)。timeout を 300 秒にする。
2. 出力を確認する。
   - `AGMSG-DIRECTIVE: For this running session, invoke the Monitor tool now with:` があれば、続く `command:` / `description:` / `persistent: true` をそのまま Monitor ツールに渡して起動する。
   - `A watch.sh is already streaming into this session` があれば、Monitor は起動済みなので何もしない。
   - `status=ready name=codex` があれば codex 側の bridge は armed 済み。
3. 完了報告をする。team 名、codex の pane id、Monitor の状態、以後は codex からのメッセージが Monitor 経由で届くことを伝える。

## 失敗時

- `codex の bridge が ... 以内に armed になりませんでした` の場合は、表示された log のパスを報告して停止する。codex の pane は残っているので、ユーザーが手で確認できる。
- `複数の team に登録されています` の場合は、候補を示して `-t` の指定をユーザーに求める。
