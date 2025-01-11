#!/usr/bin/bash
export LANG='POSIX'
exec 2>/dev/null

case "$ROFI_RETV" in
    28) LANG="$SYSTEM_LANG" exec "${0%/*}/../rofi-main.sh"
    ;;
esac

ROW_ICON_FONT='feather 12'

if [ -f '/etc/os-release' ]; then

    . /etc/os-release

    A_='' A="<span font_desc='${ROW_ICON_FONT}' weight='bold'>${A_}</span>   ${PRETTY_NAME:-${NAME}}"

fi

if [ -f '/sys/devices/virtual/dmi/id/product_name' ]; then

    IFS= read -r MACH_PRODUCT_NAME </sys/devices/virtual/dmi/id/product_name

    B_='' B="<span font_desc='${ROW_ICON_FONT}' weight='bold'>${B_}</span>   ${MACH_PRODUCT_NAME:-?}"

fi

if [ -f '/proc/version' -o -x "$(command -v uname)" ]; then

    IFS= read -r _ _ UNAME_R _ </proc/version

    C_='' C="<span font_desc='${ROW_ICON_FONT}' weight='bold'>${C_}</span>   ${UNAME_R:-$(uname -r)}"

fi

if [ -f '/proc/uptime' -o -x "$(command -v uptime)" ]; then

    IFS='.' read -r S _ </proc/uptime

    D="$((S/60/60/24))"
    H="$((S/60/60%24))"
    M="$((S/60%60))"

    [ "$D" -lt 2 ] || DP='s'
    [ "$H" -lt 2 ] || HP='s'
    [ "$M" -lt 2 ] || MP='s'
    [ "$S" -lt 2 ] || SP='s'

    [ "$D" -eq 0 ] || UPTIME_P="${D} day${DP}, "
    [ "$H" -eq 0 ] || UPTIME_P="${UPTIME_P}${H} hour${HP}, "
    [ "$M" -eq 0 ] || UPTIME_P="${UPTIME_P}${M} minute${MP}"
    [  -n  "$M"  ] || UPTIME_P="${UPTIME_P}${S} second${SP}"

    UPTIME_P="${UPTIME_P:-$(uptime -p)}"

    D_='' D="<span font_desc='${ROW_ICON_FONT}' weight='bold'>${D_}</span>   ${UPTIME_P##*up\ }"

fi

if [ -x "$(command -v xrandr)" ]; then

    XRANDR_CURRENT="$(xrandr --nograb --current | sed -n -e 's|^[ ]*\(.*\)\*.*$|\1|p')" \
    RESOLUTION_RATE="${XRANDR_CURRENT%%\ *} @ ${XRANDR_CURRENT##*\ }Hz"

    E_='' E="<span font_desc='${ROW_ICON_FONT}' weight='bold'>${E_}</span>   ${RESOLUTION_RATE}"

fi

if [ -x "$(command -v df)" ]; then

	{ read; read -r _ fs tot _ av _ _; } < <(df -h -T)
	FILESYSTEM_INFO="${fs} ${tot} @ ${av}"

	F_='' F="<span font_desc='${ROW_ICON_FONT}' weight='bold'>${F_}</span>   ${FILESYSTEM_INFO}"

fi

G_='' G="<span font_desc='${ROW_ICON_FONT}' weight='bold'>${G_}</span>   ${DESKTOP_SESSION}"

MESSAGE="<span font_desc='${MSG_ICON_FONT}' weight='bold'></span>"

printf '%b\n' '\0use-hot-keys\037true' '\0markup-rows\037true' "\0message\037${MESSAGE}"
printf '%s\0nonselectable\037true\n' "$A" "$B" "$C" "$D" "$E" "$F" "$G"

exit ${?}
