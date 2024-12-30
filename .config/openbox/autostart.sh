#!/bin/sh

exec >/dev/null 2>&1
. "${HOME}/.joyfuld"

[ -z "$BASH" ] || shopt -s expand_aliases

joyd_toggle_mode apply
joyd_tray_programs exec

picom --daemon &

if [ -x "$(command -v lxpolkit)" ]; then
    lxpolkit &
else
    $(find ${LIBS_PATH} -type f -iname 'polkit-gnome-authentication-agent-*' | sed 1q) &
fi

# Any additions should be added below.
light-locker &
