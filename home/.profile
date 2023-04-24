export PATH=/usr/local/games:$HOME/bin:$HOME/.local/bin:$PATH
export PAGER=${PAGER:-less}
export EDITOR=nvim
export GIT_PAGER=delta

export DBUS_SESSION_BUS_ADDRESS=unix:path=${XDG_RUNTIME_DIR}/dbus

export BEMENU_OPTS="bemenu-run -b --ifne -w --hp 8 --accept-single -p '/󰄾' -f --binding vim -H 24 -B 1 --tf #2d2d2d --tb #99cc99 --bdr #99cc99 --nb #2d2d2d --nf #cccccc --ab #2d2d2d --hf #99cc99 --hb #474b51 --fb #2d2d2d"

. "$HOME/.cargo/env"
