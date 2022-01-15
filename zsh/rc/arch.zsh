if (( $+commands[sw_vers] )) && (( $+commands[arch] )); then
	alias x64='arch -x86_64'
	alias a64='arch -arm64e'
	switch-arch() {
		if  [[ "$(uname -m)" == arm64 ]]; then
			arch=x86_64
		elif [[ "$(uname -m)" == x86_64 ]]; then
			arch=arm64e
		fi
		exec arch -arch $arch /bin/zsh
	}
fi