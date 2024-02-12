if (( $+commands[rustup] )) && [[ ! -f $ZDOTDIR/functions/_rustup ]]; then
	rustup completions zsh > $ZDOTDIR/functions/_rustup
fi
