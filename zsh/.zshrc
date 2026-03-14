#
# Executes commands at the start of an interactive session.
#

#========================================#
#     Environment                        #
#========================================#
setopt NO_BG_NICE NO_HUP NO_CHECK_JOBS LONG_LIST_JOBS NOTIFY
setopt INTERACTIVE_COMMENTS

#========================================#
#     History                            #
#========================================#
HISTFILE="${ZDOTDIR:-$HOME}/.zhistory"
HISTSIZE=10000
SAVEHIST=10000
setopt BANG_HIST EXTENDED_HISTORY SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS HIST_IGNORE_SPACE HIST_SAVE_NO_DUPS HIST_VERIFY

#========================================#
#     Directory                          #
#========================================#
setopt AUTO_CD AUTO_PUSHD PUSHD_IGNORE_DUPS PUSHD_SILENT PUSHD_TO_HOME
setopt CDABLE_VARS MULTIOS EXTENDED_GLOB
setopt GLOBDOTS

#========================================#
#     Editor                             #
#========================================#
bindkey -e

#========================================#
#     Colors                             #
#========================================#
export CLICOLOR=1
export GREP_COLOR='1;30;44'

#========================================#
#     Completion                         #
#========================================#
setopt COMPLETE_IN_WORD ALWAYS_TO_END AUTO_MENU AUTO_LIST AUTO_PARAM_SLASH
unsetopt MENU_COMPLETE FLOW_CONTROL

autoload bashcompinit && bashcompinit
autoload -U compinit
compinit -i -d "$COMPDUMPFILE"

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select

#========================================#
#     Plugins                            #
#========================================#
source $HOMEBREW_DIR/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOMEBREW_DIR/share/zsh-autosuggestions/zsh-autosuggestions.zsh

#========================================#
#     Prompt                             #
#========================================#
eval "$(starship init zsh)"

ZRCDIR="$ZDOTDIR/rc"

#========================================#
#     CLI init                           #
#========================================#
# direnv
if (( $+commands[direnv] )); then
  eval "$(direnv hook zsh)"
fi

# go
if (( $+commands[go] )); then
  export GOPATH=`go env GOPATH`
  path=(
    $GOPATH/bin(N-/)
    $path
  )
fi

if (( $+commands[gpg] )); then
  export GPG_TTY=$(tty)
fi

if (( $+commands[fzf] )); then
  source <(fzf --zsh)
fi

if (( $+commands[mise] )); then
  eval "$(mise activate zsh)"
fi

# zeno.zsh (abbreviation + completion)
export ZENO_HOME="$ZDOTDIR/rc/zeno"
if [[ -f "$ZDOTDIR/plugins/zeno.zsh/zeno.zsh" ]]; then
  source "$ZDOTDIR/plugins/zeno.zsh/zeno.zsh"
  bindkey ' '  zeno-auto-snippet
  bindkey '^m' zeno-auto-snippet-and-accept-line
  bindkey '^i' zeno-completion
  bindkey '^r' zeno-history-selection
  bindkey '^x^s' zeno-insert-snippet
fi

# Cloud SDK
cloud_sdk_dir=$HOMEBREW_DIR/Caskroom/google-cloud-sdk/latest/google-cloud-sdk
if [ -f $cloud_sdk_dir/path.zsh.inc ]; then
	source $cloud_sdk_dir/path.zsh.inc
fi
if [ -f $cloud_sdk_dir/completion.zsh.inc ]; then
	source $cloud_sdk_dir/completion.zsh.inc
fi

#========================================#
#     alias                              #
#========================================#
source "$ZRCDIR/alias.zsh"

#========================================#
#     completions                        #
#========================================#
source "${ZRCDIR}/completions.zsh"

# For apple silicon
if [ $(arch) = arm64 ]; then

  #========================================#
  #     arch *                             #
  #========================================#
  source "$ZRCDIR/arch.zsh"

  #========================================#
  #     brew *                             #
  #========================================#
  source "$ZRCDIR/brew.zsh"

fi
