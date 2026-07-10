#!/usr/bin/env bash

set -Eeuo pipefail
IFS=$'\n\t'

log() {
    printf "\n\033[1;34m==>\033[0m %s\n" "$1"
}

warn() {
    printf "\n\033[1;33mWarning:\033[0m %s\n" "$1"
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

################################################################################
# Connectivity check
################################################################################
# ICMP (ping) is blocked on plenty of networks (corporate VPNs, some cloud
# hosts, some routers) even when the connection itself is fine, which made
# this check fail intermittently and abort the whole install. Try a couple of
# different methods before giving up.
log "Checking internet connection..."

check_connection() {
    if command -v curl &>/dev/null; then
        curl -fsSL --max-time 5 -o /dev/null https://archlinux.org && return 0
    fi
    if command -v ping &>/dev/null; then
        ping -c1 -W3 archlinux.org &>/dev/null && return 0
    fi
    getent hosts archlinux.org &>/dev/null && return 0
    return 1
}

check_connection || error "No internet connection detected. Connect to the internet and try again."

################################################################################
# Package Lists
################################################################################

# Core Hyprland ecosystem and session essentials. Without these, the configs
# in this repo (hyprland.lua, hyprlock.conf, waybar, etc.) have nothing to
# run against, which is the main reason a fresh install could fail depending
# on what happened to already be on the machine.
PACMAN_PACKAGES=(
    # Hyprland core + companions
    hyprland
    hyprlock
    hypridle
    hyprpolkitagent
    xdg-desktop-portal-hyprland
    qt5-wayland
    qt6-wayland

    # Desktop pieces used by this config
    waybar
    rofi
    kitty
    fish
    zsh
    neovim
    swaync
    awww

    # File manager / theming
    nautilus
    nwg-look
    gnome-themes-extra

    # Fonts
    ttf-jetbrains-mono-nerd

    # CLI tools referenced by keybindings, scripts, and shell configs
    grim
    slurp
    wl-clipboard
    brightnessctl
    playerctl
    jq
    fastfetch
    fzf
    fd
    zoxide

    # Audio / network / bluetooth
    pipewire
    pipewire-pulse
    pipewire-alsa
    wireplumber
    networkmanager
    bluez
    bluez-utils

    # Power management
    tlp

    # Build tooling needed for yay / AUR packages below
    git
    base-devel

    # Misc
    flatpak
    libnotify
)

AUR_PACKAGES=(
    ttf-iosevka-nerd
    matugen-bin
    visual-studio-code-bin
    bibata-cursor-theme-bin
    cliphist
)

FLATPAK_PACKAGES=(
    com.brave.Browser
)

################################################################################
# Pacman packages
################################################################################

log "Updating system and installing pacman packages..."

sudo pacman -Syu \
    --needed \
    --noconfirm \
    "${PACMAN_PACKAGES[@]}"

################################################################################
# yay (AUR helper)
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
