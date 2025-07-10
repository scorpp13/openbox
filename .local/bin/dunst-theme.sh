#!/usr/bin/bash

gum style \
	--foreground 13 --border-foreground 13 --border rounded --bold \
	--align center --width 30 --margin "0 2" --padding "1 0" \
	'D U N S T   T H E M E S'

# config theme
gum style --foreground 10 --margin "1 2" 'DUNST theme'
INPUT=$(find "${HOME}/.config/dunst" -name "*.dunstrc" | gum choose --limit 1)
CONFIG=$(basename "$INPUT")
CONFIGTHEME="${CONFIG%%.*}"
THEMEPATH="${HOME}/.config/dunst/dunstrc"
gum confirm "Set dunst theme?" && \
gum spin --title "Writing..." -- sleep 1 && \
cp "$INPUT" "$THEMEPATH"

# print chosen theme
clear
gum style --foreground 2 --faint 'new dunst theme'
gum style --foreground 10 --bold ". $CONFIGTHEME ."
echo ''
read -rp "Press Enter to continue" </dev/tty
