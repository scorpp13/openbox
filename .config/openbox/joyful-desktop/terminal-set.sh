#!/bin/sh

# Desc:   Set-up user's preferred terminal emulator.
# Author: Harry Kurn <alternate-se7en@pm.me>
# URL:    https://github.com/owl4ce/dotfiles/tree/ng/.config/openbox/joyful-desktop/terminal-set.sh

# SPDX-License-Identifier: ISC

# shellcheck disable=SC3044,SC2166,SC3028

export LANG='POSIX'
exec 2>/dev/null
. "${HOME}/.joyfuld"

# https://gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html#:~:text=expand_aliases
[ -z "$BASH" ] || shopt -s expand_aliases

PREF_TERM="$(joyd_launch_apps -g terminal)"

[ -x "$(command -v "${PREF_TERM%%\ *}")" ] || exec dunstify "Install \`${PREF_TERM%%\ *}\`!" \
                                                            -h string:synchronous:install-deps \
                                                            -a joyful_desktop \
                                                            -u low
exit ${?}
