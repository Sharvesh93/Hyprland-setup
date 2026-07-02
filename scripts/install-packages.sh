#!/usr/bin/env bash

set -Eeuo pipefail
IFS=$'\n\t'

################################################################################
# Functions
################################################################################

log() {
    printf "\n\033[1;34m==>\033[0m %s\n" "$1"
}

error() {
    printf "\n\033[1;31mError:\033[0m %s\n" "$1"
    exit 1
}

cleanup() {
    [[ -n "${TMPDIR:-}" && -d "$TMPDIR" ]] && rm -rf "$TMPDIR"
}

trap cleanup EXIT

################################################################################
# Checks
################################################################################

[[ -f /etc/arch-release ]] || error "This script is intended for Arch Linux."

ping -c1 archlinux.org >/dev/null 2>&1 || error "No internet connection."

sudo -v || error "Failed to obtain sudo privileges."

################################################################################
# Package Lists
################################################################################

PACMAN_PACKAGES=(
    base-devel
    git
    neovim
    fzf
    fish

    hyprland
    kitty
    rofi
    waybar
    swaync
    hyprlock
    grim
    slurp
    wl-clipboard

    pipewire
    pipewire-pulse

    flatpak

    firefox
    nautilus
    nwg-look
    gnome-themes-extra

    ttf-jetbrains-mono-nerd

    tlp

    waypaper
    mpvpaper

    libnotify
)

AUR_PACKAGES=(
    ttf-iosevka-nerd
)

FLATPAK_PACKAGES=(
    com.brave.Browser
    com.visualstudio.code
)

################################################################################
# Pacman
################################################################################

log "Updating system and installing pacman packages..."

sudo pacman -Syu \
    --needed \
    --noconfirm \
    "${PACMAN_PACKAGES[@]}"

################################################################################
# yay
################################################################################

if ! command -v yay &>/dev/null; then
    log "Installing yay..."

    TMPDIR="$(mktemp -d)"

    git clone https://aur.archlinux.org/yay.git "$TMPDIR"

    pushd "$TMPDIR" >/dev/null
    makepkg -si --noconfirm
    popd >/dev/null
else
    log "yay already installed."
fi

################################################################################
# AUR Packages
################################################################################

log "Installing AUR packages..."

yay -S \
    --needed \
    --noconfirm \
    --answerdiff=None \
    --answeredit=None \
    "${AUR_PACKAGES[@]}"

################################################################################
# Flatpak
################################################################################

if ! flatpak remote-list | grep -q flathub; then
    log "Adding Flathub..."

    flatpak remote-add \
        --if-not-exists \
        flathub \
        https://flathub.org/repo/flathub.flatpakrepo
fi

log "Installing Flatpak packages..."

flatpak install \
    -y \
    flathub \
    "${FLATPAK_PACKAGES[@]}"

################################################################################
# Fisher + Tide
################################################################################

log "Installing Fisher and Tide..."

fish <<'EOF'

if not functions -q fisher
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
    fisher install jorgebucaran/fisher
end

if not fisher list | grep -q "IlanCosman/tide"
    fisher install IlanCosman/tide@v6
end

EOF

################################################################################
# Enable Services
################################################################################

log "Enabling TLP..."

sudo systemctl enable --now tlp.service

################################################################################
# Done
################################################################################

log "Installation complete."

echo
echo "You may want to reboot before logging into Hyprland."