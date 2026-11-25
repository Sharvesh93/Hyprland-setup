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

# Helper scripts must be executable for Hyprland keybindings to work.
find "$HOME/.config/rofi" "$HOME/.config/hypr" -type f -name '*.sh' \
    -exec chmod +x {} + 2>/dev/null || true

# ---------------------------------------------------------------------
# Finish
# ---------------------------------------------------------------------

echo
success "Installation completed successfully."


printf '%s\n' "----------------------------------------------------------"
printf '%s\n' "------------- INSTALLATION COMPLETED SUCCESSFULLY ----------"
printf '%s\n' "----------------------------------------------------------"
echo "Log out and back in (or reboot) to start Hyprland with the new setup."

# Don't fail the installer when running non-interactively (e.g. piped to a log).
read -rp "Reboot now? [y/N]: " answer || answer="n"

case "${answer,,}" in
    y|yes)
        if [[ "$EUID" -eq 0 ]]; then
            reboot
        else
            sudo reboot
        fi
        ;;
    *)
        echo "Reboot skipped."
        ;;
esac
