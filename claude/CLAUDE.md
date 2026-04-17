# Global Rules

## Worktree Rules

When the primary working directory is a git worktree (path contains `.claude/worktrees/`):

- Treat the primary working directory as the repository root for ALL operations
- NEVER access files above the `.claude/worktrees/<name>/` boundary (i.e., the parent repository)
- When spawning sub-agents, explicitly specify the worktree path as the working directory and instruct them not to access the parent repository
- When constructing file paths, always use the primary working directory as the base — do not resolve upward through `.claude/worktrees/` to the parent
