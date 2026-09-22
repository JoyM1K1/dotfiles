#!/usr/bin/env zsh
set -eu
source "${0:a:h}/../lib/agent-skills.zsh"
test_root=$(mktemp -d)
trap 'rm -rf -- "$test_root"' EXIT
src="$test_root/personal skills"
codex_skills="$test_root/codex"
claude_skills="$test_root/claude"
mkdir -p "$src/example" "$codex_skills/external" "$claude_skills/external"
print -r -- personal > "$src/example/SKILL.md"
print -r -- codex-version > "$codex_skills/external/SKILL.md"
print -r -- claude-version > "$claude_skills/external/SKILL.md"
link_personal_skills "$src" "$codex_skills" "$claude_skills"
link_personal_skills "$src" "$codex_skills" "$claude_skills"
[[ "$codex_skills/example" -ef "$src/example" ]]
[[ "$claude_skills/example" -ef "$src/example" ]]
[[ $(<"$codex_skills/external/SKILL.md") == codex-version ]]
[[ $(<"$claude_skills/external/SKILL.md") == claude-version ]]

# 新しい自作スキルは自動検出し、衝突時には他方への追加も行わない。
mkdir -p "$src/added" "$claude_skills/added"
print -r -- added > "$src/added/SKILL.md"
print -r -- unrelated > "$claude_skills/added/SKILL.md"
if link_personal_skills "$src" "$codex_skills" "$claude_skills"; then
    print -u2 -- 'FAIL: conflict accepted'; exit 1
fi
[[ ! -e "$codex_skills/added" ]]
[[ $(<"$claude_skills/added/SKILL.md") == unrelated ]]
rm -r -- "$claude_skills/added"
link_personal_skills "$src" "$codex_skills" "$claude_skills"
[[ "$codex_skills/added" -ef "$src/added" ]]

# 削除された自作スキルのリンクだけを除去し、外部の壊れたリンクは残す。
ln -s "$test_root/absent" "$codex_skills/foreign-link"
rm -r -- "$src/example"
link_personal_skills "$src" "$codex_skills" "$claude_skills"
[[ ! -L "$codex_skills/example" && ! -L "$claude_skills/example" ]]
[[ -L "$codex_skills/foreign-link" && -d "$codex_skills/external" ]]
print -r -- 'PASS: repeat install, automatic discovery, conflicts, external skills unchanged, stale links'
