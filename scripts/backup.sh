#!/bin/bash

backup="$HOME/.config-backup-$(date +%F-%H%M)"

mkdir -p "$backup"

for dir in hypr waybar kitty fish rofi swaync nvim
do
    if [ -d "$HOME/.config/$dir" ]; then
        mv "$HOME/.config/$dir" "$backup/"
    fi
done