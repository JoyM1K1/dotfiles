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