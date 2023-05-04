export PATH=/usr/local/games:$HOME/bin:$HOME/.local/bin:$PATH
export PAGER=${PAGER:-less}
export EDITOR=nvim
export GIT_PAGER=delta

export DBUS_SESSION_BUS_ADDRESS=unix:path=/var/run/user/1000/dbus

. "$HOME/.cargo/env"
