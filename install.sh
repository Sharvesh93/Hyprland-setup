#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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

# ---------------------------------------------------------------------
# Checks
# ---------------------------------------------------------------------

[[ "$EUID" -ne 0 ]] || error "Do not run this installer as root."

cd "$SCRIPT_DIR"

chmod +x scripts/*.sh

# Verify required scripts exist
required_scripts=(
    install-packages.sh
    backup.sh
    install-configs.sh
    install-wallpapers.sh
)

for script in "${required_scripts[@]}"; do
    [[ -f "scripts/$script" ]] || error "Missing scripts/$script"
done

# ---------------------------------------------------------------------
# Installation
# ---------------------------------------------------------------------

log "Installing required packages..."
./scripts/install-packages.sh
success "Package installation completed."

log "Backing up existing configuration..."
./scripts/backup.sh
success "Backup completed."

log "Installing configuration files..."
./scripts/install-configs.sh
success "Configuration installed."

log "Installing wallpapers..."
./scripts/install-wallpapers.sh
success "Wallpapers installed."

# ---------------------------------------------------------------------
# Shell configuration
# ---------------------------------------------------------------------

if [[ -f scripts/.zshrc ]]; then
    cp scripts/.zshrc "$HOME/.zshrc"
    success ".zshrc installed."
else
    warn ".zshrc not found. Skipping."
fi

# ---------------------------------------------------------------------
# Permissions
# ---------------------------------------------------------------------

if [[ -d "$HOME/.config/rofi" ]]; then
    chmod +x "$HOME/.config/rofi/"* 2>/dev/null || true
fi

if [[ -d "$HOME/.config/waybar" ]]; then
    chmod +x "$HOME/.config/waybar/"* 2>/dev/null || true
fi

# ---------------------------------------------------------------------
# Finish
# ---------------------------------------------------------------------

echo
success "Installation completed successfully."

echo
echo "A reboot is recommended before logging into Hyprland."

read -rp "Reboot now? [Y/n]: " answer

case "${answer,,}" in
    n|no)
        echo "Reboot skipped."
        ;;
    *)
        reboot
        ;;
esac