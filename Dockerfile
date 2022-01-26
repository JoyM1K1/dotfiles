FROM debian:bullseye-slim

COPY . /root/dotfiles

RUN apt-get update && \
    apt-get install -y zsh vim git locales && \
    /root/dotfiles/zsh/install.zsh && \
    /root/dotfiles/vim/install.zsh

RUN localedef -f UTF-8 -i ja_JP ja_JP.utf8 && \
    echo 'LANG="ja_JP.UTF-8"' > /etc/locale.conf
ENV LANG="ja_JP.UTF-8" \
    LANGUAGE="ja_JP:ja" \
    LC_ALL="ja_JP.UTF-8" \
    TERM="xterm-256color"

ENTRYPOINT ["/bin/zsh"]
