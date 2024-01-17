# _gh
if (( $+commands[gh] )) && [[ ! -f $ZDOTDIR/functions/_gh ]]; then
    gh completion -s zsh > $ZDOTDIR/functions/_gh
fi

# _docker https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker
if (( $+commands[docker] )) && [[ ! -f $ZDOTDIR/functions/_docker ]]; then
    curl -fLo $ZDOTDIR/functions/_docker https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker
fi

# _docker-compose https://github.com/docker/compose/blob/1.29.2/contrib/completion/zsh/_docker-compose
if (( $+commands[docker-compose] )) && [[ ! -f $ZDOTDIR/functions/_docker-compose ]]; then
    curl -fLo $ZDOTDIR/functions/_docker-compose https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/zsh/_docker-compose
fi

# aws https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/cli-configure-completion.html#cli-command-completion-linux
if (( $+commands[aws_completer] )); then
	complete -C "${commands[aws_completer]}" aws
fi
