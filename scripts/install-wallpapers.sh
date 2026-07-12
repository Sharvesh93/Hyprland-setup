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

error() {
    printf "\033[1;31mError:\033[0m %s\n" "$1"
    exit 1
}

################################################################################
# Paths
################################################################################

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

SOURCE_WALLPAPERS="$SCRIPT_DIR/Wallpapers"
TARGET_WALLPAPERS="$HOME/Pictures/Wallpapers"

SOURCE_SCRIPT="$SCRIPT_DIR/scripts/wallpaper.sh"
TARGET_SCRIPT="$HOME/.local/bin/wallpaper.sh"

DEFAULT_WALLPAPER="$TARGET_WALLPAPERS/the_girl.jpg"

################################################################################
# Checks
################################################################################

[[ -d "$SOURCE_WALLPAPERS" ]] || error "Wallpaper directory not found."

################################################################################
# Directories
################################################################################

log "Creating wallpaper directories..."

mkdir -p "$TARGET_WALLPAPERS"
mkdir -p "$HOME/.local/bin"

################################################################################
# Install Wallpapers
################################################################################

log "Copying wallpapers..."

cp -a "$SOURCE_WALLPAPERS/." "$TARGET_WALLPAPERS/"

success "Wallpapers installed."

################################################################################
# Install wallpaper script
################################################################################

if [[ -f "$SOURCE_SCRIPT" ]]; then

    install -Dm755 \
        "$SOURCE_SCRIPT" \
        "$TARGET_SCRIPT"

    success "Wallpaper script installed."

else

    warn "wallpaper.sh not found."

fi

################################################################################
# Set Default Wallpaper
################################################################################

if [[ -f "$DEFAULT_WALLPAPER" ]]; then

    if command -v awww >/dev/null; then

        log "Setting default wallpaper..."

        awww img "$DEFAULT_WALLPAPER" || warn "Failed to set wallpaper."

    else

        warn "awww is not installed."

    fi

else

    warn "Default wallpaper not found."

fi

################################################################################
# Generate Matugen Theme
################################################################################

if command -v matugen >/dev/null && [[ -f "$DEFAULT_WALLPAPER" ]]; then

    log "Generating Matugen theme..."

    matugen image \
        "$DEFAULT_WALLPAPER" \
        --mode dark \
        --source-color-index 0 \
        --quiet || warn "Matugen failed."

else

    warn "Skipping Matugen."

fi

################################################################################
# Done
################################################################################

echo

success "Wallpaper installation completed."
