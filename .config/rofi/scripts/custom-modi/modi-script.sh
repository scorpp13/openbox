#!/usr/bin/bash

export LANG='POSIX'
exec 2>/dev/null

case "$ROFI_RETV" in
    28) LANG="$SYSTEM_LANG" exec "${0%/*}/../rofi-main.sh"
    ;;
esac

ROW_ICON_FONT='feather 12'
MSG_ICON_FONT='feather 48'

A_='' A="<span font_desc='${ROW_ICON_FONT}' weight='bold'>${A_}</span>   ARC extractor"
B_='' B="<span font_desc='${ROW_ICON_FONT}' weight='bold'>${B_}</span>   Font list"
C_='' C="<span font_desc='${ROW_ICON_FONT}' weight='bold'>${C_}</span>   JPG convertor"
D_='' D="<span font_desc='${ROW_ICON_FONT}' weight='bold'>${D_}</span>   GIF convertor"
E_='' E="<span font_desc='${ROW_ICON_FONT}' weight='bold'>${E_}</span>   Merge images"

case "${@}" in
    "$A") eval 'exec kitty -e extract.sh >&2'
    ;;
    "$B") eval 'exec kitty -e fontsearch.sh >&2'
    ;;
    "$C") eval 'exec kitty -e convert-to-jpg.sh >&2'
    ;;
    "$D") eval 'exec kitty -e convert-to-gif.sh >&2'
    ;;
    "$E") eval 'exec kitty -e merge_img.sh >&2'
    ;;
esac

MESSAGE="<span font_desc='${MSG_ICON_FONT}' weight='bold'></span>"

printf '%b\n' '\0use-hot-keys\037true' '\0markup-rows\037true' "\0message\037${MESSAGE}" \
              "$A" "$B" "$C" "$D" "$E"

exit ${?}
