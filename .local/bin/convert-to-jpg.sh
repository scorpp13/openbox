#!/usr/bin/bash

# This script convert *.png images to *.jpg
DIR=$(gum file --directory "$HOME")
INPUT=$(find "$DIR" | gum choose --no-limit)
gum confirm "Convert selected images?" && \
gum spin --title "Converting..." -- sleep 1 && \
cd "$DIR" && mogrify -format jpg "$INPUT"
echo ''
read -rp "Press Enter to continue" </dev/tty
