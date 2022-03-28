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

