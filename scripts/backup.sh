#!/usr/bin/env bash

set -Eeuo pipefail

################################################################################
# Logging
################################################################################

log() {
    printf "\n\033[1;34m==>\033[0m %s\n" "$1"
}

success() {
    printf "\033[1;32m✓\033[0m %s\n" "$1"
}

warn() {
    printf "\033[1;33mWarning:\033[0m %s\n" "$1"
}

################################################################################
# Configuration
################################################################################

BACKUP_ROOT="$HOME/.config-backup"
BACKUP_DIR="$BACKUP_ROOT/$(date +%Y-%m-%d_%H-%M-%S)"

CONFIGS=(
    hypr
    waybar
    rofi
    kitty
    fish
    nvim
    swaync
)

FILES=(
    .zshrc
    .gtkrc-2.0
)

################################################################################
# Backup
################################################################################

FOUND=false

backup_config() {

    local dir="$1"

    if [[ -d "$HOME/.config/$dir" ]]; then

        [[ "$FOUND" == false ]] && mkdir -p "$BACKUP_DIR"

        cp -a "$HOME/.config/$dir" "$BACKUP_DIR/"

        success "Backed up $dir"

        FOUND=true

    else

        warn "$dir not found. Skipping."

    fi
}

backup_file() {

    local file="$1"

    if [[ -f "$HOME/$file" ]]; then

        [[ "$FOUND" == false ]] && mkdir -p "$BACKUP_DIR"

        cp -a "$HOME/$file" "$BACKUP_DIR/"

        success "Backed up $file"

        FOUND=true

    fi
}

################################################################################
# Run
################################################################################

log "Checking existing configuration..."

for dir in "${CONFIGS[@]}"; do
    backup_config "$dir"
done

for file in "${FILES[@]}"; do
    backup_file "$file"
done

################################################################################
# Result
################################################################################

echo

if [[ "$FOUND" == true ]]; then

    success "Backup saved to:"
    echo "$BACKUP_DIR"

else

    echo "No existing Hyprland configuration found."
    echo "Skipping backup."

fi