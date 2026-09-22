#!/usr/bin/env zsh
set -eu
CURRENT_DIR=${0:a:h}
source "$CURRENT_DIR/../lib/agent-skills.zsh"
link_personal_skills "$CURRENT_DIR/skills" "$HOME/.agents/skills" "$HOME/.claude/skills"
