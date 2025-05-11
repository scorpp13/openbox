#!/usr/bin/bash

export LANG='POSIX'
exec 2>/dev/null

case "$ROFI_RETV" in
    28) LANG="$SYSTEM_LANG" exec "${0%/*}/../rofi-main.sh"
    ;;
esac

ROW_ICON_FONT='feather 12'
MSG_ICON_FONT='feather 48'

A_='' A="<span font_desc='${ROW_ICON_FONT}' weight='bold'>${A_}</span>   Wallpaper"
B_='' B="<span font_desc='${ROW_ICON_FONT}' weight='bold'>${B_}</span>   Rofi Theme"
C_='' C="<span font_desc='${ROW_ICON_FONT}' weight='bold'>${C_}</span>   Dunst Theme"
D_='' D="<span font_desc='${ROW_ICON_FONT}' weight='bold'>${D_}</span>   Openbox Theme"
E_='' E="<span font_desc='${ROW_ICON_FONT}' weight='bold'>${E_}</span>   Tint2 Theme"
F_='' F="<span font_desc='${ROW_ICON_FONT}' weight='bold'>${F_}</span>   GTK Theme"
G_='' G="<span font_desc='${ROW_ICON_FONT}' weight='bold'>${G_}</span>   Qt Theme"

case "${@}" in
    "$A") eval 'exec waypaper >&2'
    ;;
    "$B") eval 'exec kitty -e rofi-theme.sh >&2'
    ;;
    "$C") eval 'exec kitty -e dunst-theme.sh >&2'
    ;;
    "$D") eval 'exec obconf >&2'
    ;;
    "$E") eval 'exec tint2conf >&2'
    ;;
    "$F") eval 'exec lxappearance >&2'
    ;;
    "$G") eval 'exec qt6ct >&2'
    ;;
esac

MESSAGE="<span font_desc='${MSG_ICON_FONT}' weight='bold'></span>"

printf '%b\n' '\0use-hot-keys\037true' '\0markup-rows\037true' "\0message\037${MESSAGE}" \
              "$A" "$B" "$C" "$D" "$E" "$F" "$G"

exit ${?}
