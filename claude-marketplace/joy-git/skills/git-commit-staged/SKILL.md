---
allowed-tools: Bash(git status:*), Bash(git diff:*), Bash(git commit:*)
description: 現在stagedな変更のみcommitする
---

## Context

- Current git status: !`git status`
- Staged changes: !`git diff --cached`
- Current branch: !`git branch --show-current`
- Recent commits: !`git log --oneline -10`

## Your task

現在stagedされている変更のみをcommitしてください。

- stagedされた変更がない場合は、その旨をユーザーに伝えて終了する
- 変更内容と既存のcommitスタイルに基づいて適切なcommitメッセージを作成する
- `git commit` でcommitする
- **`git add` は絶対にしないこと。unstaged/untrackedなファイルには一切触れないこと**

You have the capability to call multiple tools in a single response. Do not use any other tools or do anything else. Do not send any other text or messages besides these tool calls.
