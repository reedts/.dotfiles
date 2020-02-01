# enable colors for ls
export LS_OPTIONS='--color=auto'

# modify less to use colors
export PAGER=${PAGER:-less}
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

export EDITOR=nvim


# Local variables:
export PATH=/usr/local/games:$HOME/bin:$PATH
export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_AUTO_SCREEN_SCALE_FACTOR=1.5
