#!/usr/bin/bash

SYSTEM_LANG="$LANG"
export LANG='POSIX'
exec >/dev/null 2>&1

SYSINFO=''
SCRIPT=''
SESSION=''
MEDIA=''
THEME=''

CUSTOM_MODI="\
${SYSINFO}:${0%/*}/custom-modi/modi-sysinfo.sh,\
${SCRIPT}:${0%/*}/custom-modi/modi-script.sh,\
${SESSION}:${0%/*}/custom-modi/modi-session.sh,\
${MEDIA}:${0%/*}/custom-modi/modi-media.sh,\
${THEME}:${0%/*}/custom-modi/modi-theme.sh"

case "${1}" in
    sys*) MODI="$SYSINFO"
    ;;
    scr*) MODI="$SCRIPT"
    ;;
    ses*) MODI="$SESSION"
    ;;
    med*) MODI="$MEDIA"
    ;;
    the*) MODI="$THEME"
    ;;
esac

SYSTEM_LANG="$SYSTEM_LANG" \
exec rofi -theme-str '@import "exts.rasi"' \
          -modi "$CUSTOM_MODI" \
          -no-show-icons \
          -no-lazy-grab \
          -no-plugins \
          -kb-custom-19 '' \
          -kb-move-char-back '' \
          -kb-move-char-forward '' \
          -kb-mode-previous 'Left' \
          -kb-mode-next 'Right' \
          -show "${MODI:-${SYSINFO}}"

exit ${?}
