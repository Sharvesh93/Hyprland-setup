#!/usr/bin/env bash

set -e

BACKUP_DIR="$HOME/.config-backup/$(date +%Y-%m-%d_%H-%M-%S)"

mkdir -p "$BACKUP_DIR"

for dir in hypr waybar rofi kitty fish nvim swaync; do
    if [ -d "$HOME/.config/$dir" ]; then
        cp -r "$HOME/.config/$dir" "$BACKUP_DIR/"
        echo "Backed up $dir"
    fi
done