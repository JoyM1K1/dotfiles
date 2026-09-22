# Skill Building Guide Summary

PDFガイド「[The Complete Guide to Building Skills for Claude](https://resources.anthropic.com/hubfs/The-Complete-Guide-to-Building-Skill-for-Claude.pdf)」の要点。

## スキルの基本構造

```
your-skill-name/
├── SKILL.md                # 必須 - メインスキルファイル
├── scripts/                # オプション - 実行可能コード
├── references/             # オプション - ドキュメント
└── assets/                 # オプション - テンプレート等
```

## Progressive Disclosure（3層構造）

1. **First level（frontmatter）**: 常にシステムプロンプトに読み込まれる。スキルをいつ使うかの判断材料
2. **Second level（SKILL.md本文）**: Claudeがスキルを選択した時に読み込まれる。メインの指示
3. **Third level（references等）**: 必要に応じてClaudeが参照する追加ファイル

## Frontmatterルール

### 必須フィールド

**name:**
- kebab-caseのみ（スペース・アンダースコア・大文字不可）
- フォルダ名と一致させる
- "claude"や"anthropic"は使用不可

**description:**
- 構造: `[What it does] + [When to use it] + [Key capabilities]`
- 1024文字以下
- XMLタグ（< >）禁止
- 具体的なトリガーフレーズを含める
- 関連するファイルタイプがあれば言及する

### オプションフィールド

- `allowed-tools`: ツール制限
- `license`: MIT, Apache-2.0等
- `compatibility`: 環境要件（1-500文字）
- `metadata`: author, version, mcp-server等

### Good description例

```yaml
# 具体的でアクション可能
description: Analyzes Figma design files and generates developer handoff documentation. Use when user uploads .fig files, asks for "design specs", "component documentation", or "design-to-code handoff".

# トリガーフレーズ含む
description: Manages Linear project workflows including sprint planning, task creation, and status tracking. Use when user mentions "sprint", "Linear tasks", "project planning", or asks to "create tickets".
```

### Bad description例

```yaml
# 曖昧すぎる
description: Helps with projects.

# トリガーがない
description: Creates sophisticated multi-page documentation systems.

# 技術的すぎてユーザー視点がない
description: Implements the Project entity model with hierarchical relationships.
```

## セキュリティ制限

**Frontmatter内で禁止:**
- XMLアングルブラケット（< >）
- nameに "claude" や "anthropic" を含むスキル（予約済み）
- YAML内でのコード実行（安全なYAMLパースを使用）

## Instruction作成のベストプラクティス

### 具体的で実行可能に

Good:
```
Run `python scripts/validate.py --input {filename}` to check data format.
If validation fails, common issues include:
- Missing required fields (add them to the CSV)
- Invalid date formats (use YYYY-MM-DD)
```

Bad:
```
Validate the data before proceeding.
```

### 重要な指示の配置

- 重要な指示はファイル先頭に置く
- `## Important` や `## Critical` ヘッダーを使う
- 必要なら繰り返す

### エラーハンドリング

よくあるエラーと解決策を含める：
```markdown
## Common Issues

### MCP Connection Failed
If you see "Connection refused":
1. Verify MCP server is running
2. Confirm API key is valid
3. Try reconnecting
```

### リファレンスリソースを明確にリンクする

Good:
```
Before writing queries, consult `references/api-patterns.md` for:
- Rate limiting guidance
- Pagination patterns
- Error codes and handling
```

### 曖昧な言語を避ける

Bad: `Make sure to validate things properly`

Good:
```
CRITICAL: Before calling create_project, verify:
- Project name is non-empty
- At least one team member assigned
- Start date is not in the past
```

## スキルカテゴリ

### Category 1: Document & Asset Creation
一貫した高品質な出力の生成。スタイルガイド埋め込み、テンプレート、品質チェックリスト。

### Category 2: Workflow Automation
複数ステップのプロセスの自動化。バリデーションゲート、テンプレート、改善提案。

### Category 3: MCP Enhancement
MCPツールの効果的な使い方をガイド。複数MCP呼び出しの連携、エラーハンドリング。

## クイックチェックリスト

### 開発前
- [ ] 2-3個の具体的なユースケースを特定
- [ ] 必要なツール（built-inまたはMCP）を特定
- [ ] フォルダ構造を計画

### 開発中
- [ ] フォルダ名がkebab-case
- [ ] SKILL.mdファイルが存在（正確なスペル）
- [ ] YAML frontmatterに `---` 区切り
- [ ] nameがkebab-case、スペース・大文字なし
- [ ] descriptionにWHATとWHENが含まれる
- [ ] XMLタグ（< >）がない
- [ ] instructionが具体的で実行可能
- [ ] エラーハンドリングが含まれる
- [ ] 例が提供されている
- [ ] referencesが明確にリンクされている

### アップロード前
- [ ] 明示的なタスクでトリガーされる
- [ ] 言い換えリクエストでもトリガーされる
- [ ] 無関係なトピックではトリガーされない
- [ ] 機能テストがパスする
- [ ] ツール統合が動作する（該当する場合）
- [ ] .zipファイルに圧縮済み

### アップロード後
- [ ] 実際の会話でテスト
- [ ] under/over-triggering を監視
- [ ] ユーザーフィードバックを収集
- [ ] descriptionとinstructionを改善
- [ ] metadataのバージョンを更新

## トラブルシューティング

### スキルがアップロードできない
- **"Could not find SKILL.md"**: ファイル名が正確に `SKILL.md` か確認（大文字小文字区別）
- **"Invalid frontmatter"**: `---` 区切りがあるか、YAMLフォーマットが正しいか確認
- **"Invalid skill name"**: nameにスペースや大文字がないか確認

### スキルがトリガーされない
- descriptionが具体的か確認
- トリガーフレーズが含まれているか確認
- 対処: descriptionにより詳細なキーワードを追加

### スキルが頻繁にトリガーされすぎる
- descriptionが広すぎないか確認
- 対処: negative trigger（「〜には使わない」）を追加、より具体的に

descriptionにnegative triggerを追加する例:
```yaml
description: Advanced data analysis for CSV files. Use for
  statistical modeling, regression, clustering. Do NOT use for
  simple data exploration (use data-viz skill instead).
```

スコープを明確化する例:
```yaml
description: PayFlow payment processing for e-commerce. Use
  specifically for online payment workflows, not for general
  financial queries.
```

### MCP接続問題
- **MCP serverが接続されているか確認**: Settings > Extensions で "Connected" 表示
- **認証を確認**: APIキーが有効で期限切れでないか、適切なスコープが付与されているか
- **MCPを独立してテスト**: スキルなしでClaudeに直接MCP呼び出しを依頼
- **ツール名を確認**: スキルが参照するツール名がMCPサーバーの正確な名前と一致するか（大文字小文字区別）

### 指示が守られない
- 指示が冗長すぎないか確認（箇条書きと番号リストを使う）
- 重要な指示がファイル先頭にあるか確認
- 詳細なリファレンスは `references/` に分離
- SKILL.mdは5,000語以下に保つ

### モデルの「怠慢」対策
Performance Notes で明示的に促す:
```
## Performance Notes
- Take your time to do this thoroughly
- Quality is more important than speed
- Do not skip validation steps
```

### 高度なテクニック: バリデーションスクリプト
重要なチェックは言語指示ではなくスクリプトで検証する。コードは決定論的で、言語解釈に依存しない。

### コンテキストが大きすぎる
- 詳細ドキュメントを `references/` に移動
- インラインではなくリンクで参照
