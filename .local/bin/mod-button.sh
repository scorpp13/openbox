#!/bin/sh

export LANG='POSIX'
exec 2>/dev/null

THEMES_DIR="${HOME}/.themes"
OB_BUTTON_DIR="${THEMES_DIR}/openbox.button"
OB_THEME_DIR="${THEMES_DIR}/Fleon/openbox-3"
if [ ! -d "$OB_THEME_DIR" ]; then exit 1; fi

case "${1}" in
    '') BUTTON="$(for LS in "$OB_BUTTON_DIR"/*; do
    	[ ! -d "$LS" ] || echo "${LS##*/}"
    		done \
            | rofi -theme-str '@import "action.rasi"' \
                   -no-show-icons \
                   -no-lazy-grab \
                   -no-plugins \
                   -dmenu \
                   -mesg 'Choose Button-Style for openbox windows')"
        [ -n "$BUTTON" ] || exit 1
		ln -fnrs "${OB_BUTTON_DIR}/${BUTTON}"/*.'xbm' "${OB_THEME_DIR}/"
    ;;
esac

openbox --reconfigure --restart &

exit ${?}
