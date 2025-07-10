#!/usr/bin/bash

gum style \
	--foreground 13 --border-foreground 13 --border rounded --bold \
	--align center --width 30 --margin "0 2" --padding "1 0" \
	'R O F I   T H E M E S'

# config theme
gum style --foreground 10 --margin "1 2" 'CONFIG theme'
INPUT=$(find "${HOME}/.config/rofi/themes/colorschemes" -name "*.rasi" | gum choose --limit 1)
CONFIG=$(basename "$INPUT")
CONFIGTHEME="${CONFIG%%.*}"
THEMEPATH="${HOME}/.config/rofi/themes/colorschemes/"
gum confirm "Set config_theme?" && \
gum spin --title "Writing..." -- sleep 1 && \
echo @import "'${THEMEPATH}${CONFIGTHEME}'" > "${HOME}/.config/rofi/config_theme.rasi"

# print chosen theme
clear
gum style --foreground 2 --faint 'new rofi theme'
gum style --foreground 10 --bold ". $CONFIGTHEME ."
echo ''
read -rp "Press Enter to continue" </dev/tty
