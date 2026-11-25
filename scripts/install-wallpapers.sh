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
    printf "\033[1;31mError:\033[0m %s\n" "$1" >&2
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

# Must be a file that actually exists in Wallpapers/ (the old value
# "the_girl.jpg" did not exist, so no wallpaper or theme was ever applied).
DEFAULT_WALLPAPER="$TARGET_WALLPAPERS/wallhaven-211xrg.jpg"

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
# Install wallpapers
################################################################################

log "Copying wallpapers..."

cp -a "$SOURCE_WALLPAPERS/." "$TARGET_WALLPAPERS/"

success "Wallpapers installed."

################################################################################
# Install helper script
################################################################################

if [[ -f "$SOURCE_SCRIPT" ]]; then
    install -Dm755 "$SOURCE_SCRIPT" "$TARGET_SCRIPT"
    success "Wallpaper script installed."
else
    error "wallpaper.sh not found."
fi

################################################################################
# Apply initial wallpaper + theme
################################################################################

if [[ ! -f "$DEFAULT_WALLPAPER" ]]; then
    DEFAULT_WALLPAPER="$(find "$TARGET_WALLPAPERS" -type f \
        \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) \
        -print -quit)"
fi

if [[ -n "$DEFAULT_WALLPAPER" && -f "$DEFAULT_WALLPAPER" ]]; then
    log "Applying initial wallpaper and generating theme..."
    if ! "$TARGET_SCRIPT" init "$DEFAULT_WALLPAPER"; then
        warn "Could not apply the initial wallpaper/theme. Run '$TARGET_SCRIPT init' later."
    fi
else
    warn "No wallpapers found to apply."
fi

echo
success "Wallpaper installation completed."
