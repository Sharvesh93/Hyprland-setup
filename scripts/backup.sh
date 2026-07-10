#!/usr/bin/env bash

set -e

BACKUP_DIR="$HOME/.config-backup/$(date +%Y-%m-%d_%H-%M-%S)"
BACKUP_DONE=false

backup() {
    local dir="$1"

    if [[ -d "$HOME/.config/$dir" ]]; then
        if [[ "$BACKUP_DONE" == false ]]; then
            mkdir -p "$BACKUP_DIR"
            BACKUP_DONE=true
        fi

        echo "Backing up $dir..."
        cp -r "$HOME/.config/$dir" "$BACKUP_DIR/"
    else
        echo "Skipping $dir (not installed)"
    fi
}

# Hyprland rice components
backup hypr
backup waybar
backup rofi
backup kitty
backup fish
backup nvim
backup swaync

# Optional files
[[ -f "$HOME/.zshrc" ]] && cp "$HOME/.zshrc" "$BACKUP_DIR/" || true
[[ -f "$HOME/.gtkrc-2.0" ]] && cp "$HOME/.gtkrc-2.0" "$BACKUP_DIR/" || true

if [[ "$BACKUP_DONE" == false ]]; then
    echo "No existing Hyprland configuration found. Skipping backup."
else
    echo "Backup completed successfully."
fi