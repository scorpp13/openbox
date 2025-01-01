#!/bin/sh

export LANG='POSIX'
exec 2>/dev/null

case "$ROFI_RETV" in
    28) LANG="$SYSTEM_LANG" exec "${0%/*}/../rofi-main.sh"
    ;;
esac

ROW_ICON_FONT='feather 12'
MSG_ICON_FONT='feather 48'

A_='' A="<span font_desc='${ROW_ICON_FONT}' weight='bold'>${A_}</span>   Change Theme"
B_='' B="<span font_desc='${ROW_ICON_FONT}' weight='bold'>${B_}</span>   Change Mode"

case "${@}" in
    "$A") joyd_toggle_mode
    ;;
    "$B") joyd_toggle_mode mode
    ;;
esac

MESSAGE="<span font_desc='${MSG_ICON_FONT}' weight='bold'></span>"

printf '%b\n' '\0use-hot-keys\037true' '\0markup-rows\037true' "\0message\037${MESSAGE}" \
              "$A" "$B" "$C"

exit ${?}
