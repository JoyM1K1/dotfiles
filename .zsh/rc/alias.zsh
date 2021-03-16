trash() {
    mv $1 ~/.Trash
}

echo-path() {
    echo ${PATH//:/\\n}
}