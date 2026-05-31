---
description: 現在の会話から重要な学びをドキュメント化
---

このセッションで得られた重要な発見・学びを分析し、
`~/github/JoyM1K1/JoyM1K1-docs/`(Obsidian vault 兼 git リポジトリ)に保存してください。

以下の手順で進めること。

## 1. 学びの抽出

このセッションから保存する価値のある学びを抽出する：

- 解決したバグとその原因・解決策
- 発見したベストプラクティス
- 新しく学んだAPIやライブラリの使い方
- 今後の注意点

**汎用性のルール**: 他のプロジェクトでも再利用できる形に一般化して書くこと。

- 具体的すぎるビジネスロジック、社内・案件固有の仕様、プロジェクト固有の名前は落とすか、一般的な例に置き換える
- 残すのは「ツール・ライブラリ・言語・OS の挙動として再現する事実」と「その対処法」
- 一般化すると意味が失われる学びは、保存対象から外す

## 2. 既知の問題かチェック

新規ファイルを作る前に、同じトピックが既にドキュメント化されていないか vault を検索する：

```bash
obsidian vault=JoyM1K1-docs search query=<キーワード>
obsidian vault=JoyM1K1-docs search:context query=<キーワード>   # マッチ行の文脈付き
```

Obsidian CLI が失敗する場合(アプリ未起動など)は `grep -ril <キーワード> ~/github/JoyM1K1/JoyM1K1-docs/` で代用する。

- **既存ドキュメントが同じ問題を扱っている** → 新規作成せず、その既存ファイルに追記・更新する(日付の古さは気にしない)
- **既知だが新しい知見が何もない** → その旨をユーザーに伝え、そのトピックの保存はスキップする
- **未知** → 新規ファイルを作成する

## 3. ブランチを切る

複数のPCから更新されるため、main へ直接 commit せず branch → merge のスタイルを取る：

```bash
cd ~/github/JoyM1K1/JoyM1K1-docs
git status   # 未コミットの変更があればユーザーに報告して中断
git fetch origin
git switch -c docs/YYYY-MM-DD-<トピック> origin/main
```

必ず `origin/main` を起点にすること(ローカル main が古い可能性があるため)。

## 4. ドキュメントの作成・更新

ブランチを切った**後に**ファイルを書く。

- 新規ファイル名は `YYYY-MM-DD-{トピック}.md` 形式(日付は今日)
- 既存ファイルの書き方に合わせる: 冒頭に `# タイトル` と1〜2文の要約、以降「現象 → 原因 → 解決策」などの構成
- 既存トピックへの追記の場合は、ファイル内の適切なセクションに統合する(末尾に雑に足さない)

ファイル操作にはなるべく Obsidian CLI を使う(vault のインデックスが即時更新されるため)：

```bash
obsidian vault=JoyM1K1-docs create path=<ファイル名>.md content="..."
obsidian vault=JoyM1K1-docs append path=<ファイル名>.md content="..."
obsidian vault=JoyM1K1-docs read path=<ファイル名>.md
```

CLI が使えない場合は通常の Write / Edit ツールで直接ファイルを操作してよい。

## 5. commit して main へ merge

```bash
git add <作成・更新したファイルのみ> && git commit -m "docs: <内容の要約>"
git switch main
git merge --ff-only origin/main   # ローカル main を最新化
git merge --no-ff docs/YYYY-MM-DD-<トピック>
git push origin main
git branch -d docs/YYYY-MM-DD-<トピック>
```

- commit メッセージは既存の履歴に合わせて `docs: ...` 形式の日本語
- push が拒否された場合(他のPCが先に push した場合)は `git pull --no-rebase origin main` で merge してから再 push する
- merge でコンフリクトした場合は両方の内容が残るように解決する。自信がなければユーザーに確認する

## 6. 結果の報告

保存したファイル名と、スキップ・統合したトピックがあればその理由を簡潔に報告する。
