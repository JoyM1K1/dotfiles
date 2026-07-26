trash() {
    mv $* ~/.Trash
}

echo-path() {
    echo ${PATH//:/\\n}
}

echo-fpath() {
    echo ${FPATH//:/\\n}
}

echo-cdpath() {
    echo ${CDPATH//:/\\n}
}

key-generate() {
    ssh-keygen -t ed25519 -m PEM
}

# agmsg の codex monitor shim があれば経由し、なければ本物の codex にフォールバックする
codex() {
  local shim="${AGMSG_DIR:-$HOME/.agents/skills/agmsg}/scripts/drivers/types/codex/codex-shim.sh"
  if [[ -x "$shim" ]]; then
    "$shim" "$@"
  else
    command codex "$@"
  fi
}
