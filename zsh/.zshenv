#
# Defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

export COMPDUMPFILE="${ZDOTDIR:-$HOME}/.zcompdump"
export HOMEBREW_DIR=/opt/homebrew
export DOTFILES_DIR="${ZDOTDIR:h}"
export BREWFILE_SUFFIX=
export ZELLIJ_CONFIG_FILE="$DOTFILES_DIR/zellij/config.kdl"
export STARSHIP_CONFIG="$DOTFILES_DIR/starship/starship.toml"

# Load local environment variables if the file exists
if [[ -f "${ZDOTDIR:-$HOME}/.zshenv_local" ]]; then
  source "${ZDOTDIR:-$HOME}/.zshenv_local"
fi

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi
