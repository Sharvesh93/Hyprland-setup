#!/usr/bin/env bash

set -Eeuo pipefail
IFS=$'\n\t'

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

[[ -f /etc/arch-release ]] || error "This script is intended for Arch Linux."

ping -c1 archlinux.org >/dev/null 2>&1 || error "No internet connection."


################################################################################
# Package Lists
################################################################################

PACMAN_PACKAGES=(
    base-devel
    neovim
    bat
    hyprland
    kitty
    rofi
    waybar
    swaync
    hyprlock
    grim
    slurp
    wl-clipboard
    eza

    pipewire
    pipewire-pulse

    fish 
    fd
    yazi
    fzf
    matugen
    flatpak
    zsh
    firefox
    brightnessctl
    nautilus
    nwg-look
    gnome-themes-extra
    ttf-jetbrains-mono-nerd
    tlp
    # waypaper
    # mpvpaper
    libnotify
)

AUR_PACKAGES=(
    ttf-iosevka-nerd
)

FLATPAK_PACKAGES=(
    com.brave.Browser
    com.visualstudio.code
)

log "Updating system and installing pacman packages..."

sudo pacman -Syu \
    --needed \
    --noconfirm \
    "${PACMAN_PACKAGES[@]}"


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

