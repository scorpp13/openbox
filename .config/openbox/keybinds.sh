#!/usr/bin/bash

cat ~/.config/openbox/rc.xml					\
	| grep 'AMC'								\
	| sed 's/AMC//g'| sed 's/<!\-\- //g'		\
	| sed 's/<keybind key=/	/g'					\
	| sed 's/\-\->//g'							\
	| sed 's/>/	/g'								\
	| rofi -dmenu -no-config -p "Keybinds" -font "Roboto Medium 18"
