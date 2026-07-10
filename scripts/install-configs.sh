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

SOURCE_CONFIG="$SCRIPT_DIR/config"

TARGET_CONFIG="$HOME/.config"

################################################################################
# Checks
################################################################################

[[ -d "$SOURCE_CONFIG" ]] || error "Config directory not found."

################################################################################
# Create directories
################################################################################

log "Creating required directories..."

mkdir -p "$TARGET_CONFIG"

mkdir -p "$TARGET_CONFIG/hypr"

mkdir -p "$TARGET_CONFIG/matugen/generated"

################################################################################
# Copy configs
################################################################################

log "Installing configuration files..."

shopt -s dotglob nullglob

configs=("$SOURCE_CONFIG"/*)

if (( ${#configs[@]} == 0 )); then
    warn "No configuration files found."
else
    cp -a "${configs[@]}" "$TARGET_CONFIG/"
fi

################################################################################
# Matugen Symlink
################################################################################

log "Configuring Matugen..."

THEME_LINK="$TARGET_CONFIG/hypr/themes"

# Remove incorrect file/directory/symlink
if [[ -e "$THEME_LINK" || -L "$THEME_LINK" ]]; then
    rm -rf "$THEME_LINK"
fi

ln -s \
    "$TARGET_CONFIG/matugen/generated" \
    "$THEME_LINK"

################################################################################
# Permissions
################################################################################

if [[ -d "$TARGET_CONFIG/rofi" ]]; then
    chmod +x "$TARGET_CONFIG/rofi/"* 2>/dev/null || true
fi

if [[ -d "$TARGET_CONFIG/waybar" ]]; then
    chmod +x "$TARGET_CONFIG/waybar/"* 2>/dev/null || true
fi

################################################################################
# Finished
################################################################################

echo

success "Configuration installed successfully."