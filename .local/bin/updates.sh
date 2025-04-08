#!/usr/bin/bash
threshhold_zero=0
icon=$HOME/.local/bin/suse_logo.svg
updates=$(zypper lu -a | grep v | wc -l)
if [ "$updates" -gt $threshhold_zero ]; then
    echo "$icon"
    dunstify --raw_icon=$HOME/.local/bin/suse_logo.svg "Updates available" "<b>$updates</b>"
fi
