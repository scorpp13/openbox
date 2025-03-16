#!/usr/bin/bash   
zypper ref
threshhold_zero=0
icon=$HOME/.local/bin/suse_logo.svg
updates=$(zypper lu | grep -Fe update -e install | wc -l)
if [ "$updates" -gt $threshhold_zero ]; then
    echo "$icon"
    dunstify --raw_icon=$HOME/.local/bin/suse_logo.svg "Updates available" "<b>$updates</b>" --timeout=0
fi
