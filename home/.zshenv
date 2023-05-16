# enable colors for ls
export LS_OPTIONS='--color=auto'

# modify less to use colors
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

source ~/.cargo/env

export HOMESHICK_DIR="$HOME/.local/share/zinit/plugins/andsens---homeshick/"

# Local variables:
export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_AUTO_SCREEN_SCALE_FACTOR=1.0

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PATH:$PYENV_ROOT/bin"

export IPYTHONDIR="${XDG_CONFIG_HOME:-$HOME/.config}/ipython"
