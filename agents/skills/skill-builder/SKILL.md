---
name: skill-builder
description: Claude Code / Codex 用スキルをインタラクティブに作成・改善する。新規作成ではユースケース定義からバリデーションまでガイド。既存スキルのレビュー・改善にも対応。Use when user says "create a skill", "build a skill", "make a skill", "new skill", "スキルを作りたい", "新しいスキル", "スキル作成", "review a skill", "improve a skill", "スキルを改善", "スキルをレビュー".
---

# Skill Builder

Claude Code / Codex 用スキルをベストプラクティスに従って作成・改善するワークフロー。
各ステップでユーザーに確認を取りながら進める。

相対パスはこの SKILL.md のあるディレクトリを基準に解決する。
Claude Code 固有の記法は Codex で自動展開されないため、共有スキルでは通常のシェル実行指示と相対リンクを使う。

詳細なルールやチェックリストは [references/guide-summary.md](references/guide-summary.md) を参照すること。この資料は Claude 向けであり、Claude 固有の制約を Codex に適用しない。Codex 用では name と description を必須とし、ツール名や配置先は対象環境に合わせる。

## Instructions

### Step 1: モード選択

まずユーザーに「新規作成」か「既存スキル改善」かを確認する。
ユーザーの発言から明らかな場合（例: "スキルを作りたい" → 新規、"スキルをレビューして" → 改善）は確認を省略してよい。

- **新規作成モード** → Step 1a へ進む
- **既存スキル改善モード** → Step 1b へ進む

### Step 1a: ユースケース定義（新規作成モード）

ユーザーに以下をヒアリングする：

1. **スキルの目的**: 何を自動化・標準化したいか
2. **対象ユーザー**: 誰が使うか（自分、チーム、コミュニティ）
3. **トリガーフレーズ**: ユーザーがどんな言葉で呼び出すか（2-3個）

以下の形式で整理して確認を取る：

```
Use Case: [スキル名]
Trigger: ユーザーが "[フレーズ1]" や "[フレーズ2]" と言ったとき
Steps:
1. [ステップ1]
2. [ステップ2]
3. [ステップ3]
Result: [期待される成果]
```

スキルカテゴリを判定する：
- **Document & Asset Creation**: 一貫した高品質な出力を生成
- **Workflow Automation**: 複数ステップのプロセスを自動化
- **MCP Enhancement**: MCPツールの使い方をガイド

### Step 1b: 既存スキルレビュー（既存スキル改善モード）

1. **対象スキルの特定**: ユーザーにレビュー対象のスキル名またはパスを確認する
2. **SKILL.mdの読み込み**: 対象スキルのSKILL.mdを読み込む
3. **`references/guide-summary.md` のチェックリストに基づきレビュー**:

   **Frontmatterレビュー:**
   - nameがkebab-caseでフォルダ名と一致しているか
   - descriptionにWHAT（何をする）とWHEN（いつ使う）が含まれるか
   - descriptionに具体的なトリガーフレーズがあるか
   - 1024文字以下か
   - XMLタグ（< >）が含まれていないか

   **Instructionレビュー:**
   - 指示が具体的で実行可能か（曖昧な表現がないか）
   - 重要な指示がファイル先頭に配置されているか
   - エラーハンドリングが含まれているか
   - 例が提供されているか
   - referencesへの参照が SKILL.md 基準の相対リンクになっているか

   **構造レビュー:**
   - SKILL.mdが5,000語以下か
   - 詳細ドキュメントがreferences/に適切に分離されているか

4. **改善提案の提示**: 問題点と具体的な修正案をリストアップする
5. **ユーザー確認後に修正を適用**: 承認された改善のみ適用する

改善完了後、Step 5のバリデーションチェックを実行して品質を確認する。

### Step 2: スキルフォルダ作成

1. スキル名をkebab-caseで決定する
   - スペース・アンダースコア・大文字は不可
   - 例: `notion-project-setup`, `api-review`
2. フォルダ構造を作成する：
   ```
   your-skill-name/
   ├── SKILL.md          # 必須（大文字、この名前のみ）
   ├── references/       # 必要に応じて
   └── scripts/          # 必要に応じて
   ```
3. ユーザーに配置先ディレクトリを確認する

IMPORTANT: README.mdはスキルフォルダ内に作らない。ドキュメントはSKILL.mdかreferences/に含める。

### Step 3: frontmatter生成

YAML frontmatterを以下のルールで生成する：

**必須フィールド:**
- `name`: kebab-case、フォルダ名と一致
- `description`: [What it does] + [When to use it] の構造。1024文字以下

**descriptionのルール:**
- 具体的なトリガーフレーズを含める
- XMLタグ（< >）は禁止
- 曖昧な表現を避ける（"Helps with projects" はNG）

**オプションフィールド:**
- `allowed-tools`: 使用するツールを制限する場合のみ指定
- `metadata`: author, versionなど

生成したfrontmatterをユーザーに提示して確認を取る。

### Step 4: instruction本文作成

以下の原則に従って本文を作成する：

1. **具体的で実行可能な指示を書く**
   - Good: `python scripts/validate.py --input {filename} でデータ形式を確認`
   - Bad: `データを検証する`

2. **重要な指示は先頭に置く**
   - `## Important` や `CRITICAL:` で強調

3. **エラーハンドリングを含める**
   - よくあるエラーと対処法を記載

4. **progressive disclosureを活用する**
   - SKILL.mdはコアの指示に集中
   - 詳細なドキュメントは `references/` に分離

5. **動的コンテキストが必要な場合**
   - 必要なコマンドをシェルツールで実行するよう本文に書く
   - 例: 「`git status` を実行して変更状況を確認する」
   - Claude Code 専用スキルに限り、動的コンテキストの埋め込み記法を使用してよい

生成した本文をユーザーに提示して確認を取る。

### Step 5: バリデーションチェック

`references/guide-summary.md` のクイックチェックリストに基づいて検証する。

**構造チェック:**
- [ ] ファイル名が正確に `SKILL.md`（大文字小文字区別）
- [ ] YAML frontmatterが `---` で囲まれている
- [ ] nameがkebab-caseでフォルダ名と一致
- [ ] descriptionにWHAT（何をする）とWHEN（いつ使う）が含まれる
- [ ] descriptionが1024文字以下
- [ ] XMLタグ（< >）が含まれていない
- [ ] instructionが具体的で実行可能

**トリガーテスト提案:**
以下のテストケースをユーザーに提示する：

```
トリガーすべき:
- "[明示的なフレーズ1]"
- "[言い換えフレーズ]"

トリガーすべきでない:
- "[無関係なトピック]"
```

全チェック通過後、スキルファイルを書き込む。

## Performance Notes

- 各ステップでユーザーの確認を取ってから次に進む
- 品質はスピードより重要
- バリデーションステップを省略しない
