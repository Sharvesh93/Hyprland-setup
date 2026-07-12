#!/usr/bin/env bash

set -Eeuo pipefail
IFS=$'\n\t'

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
# Cleanup
################################################################################

TMPDIR=""

cleanup() {
    [[ -n "$TMPDIR" && -d "$TMPDIR" ]] && rm -rf "$TMPDIR"
}

trap cleanup EXIT

################################################################################
# Checks
################################################################################

[[ -f /etc/arch-release ]] || error "This installer supports Arch Linux only."

command -v sudo >/dev/null || error "sudo is required."
command -v git >/dev/null || error "git is required."

################################################################################
# Internet
################################################################################

log "Checking internet connection..."

check_connection() {

    if command -v curl >/dev/null; then
        curl -fsSL --max-time 5 https://archlinux.org >/dev/null && return 0
    fi

    if command -v ping >/dev/null; then
        ping -c1 archlinux.org >/dev/null 2>&1 && return 0
    fi

    getent hosts archlinux.org >/dev/null 2>&1
}

check_connection || error "No internet connection."

################################################################################
# Packages
################################################################################

PACMAN_PACKAGES=(

    hyprland
    hyprlock
    hypridle
    hyprpolkitagent

    xdg-desktop-portal-hyprland
    
    eza
    qt5-wayland
    qt6-wayland

    waybar
    rofi
    kitty
    fish
    zsh
    neovim
    swaync

    awww

    nautilus
    nwg-look
    gnome-themes-extra

    ttf-jetbrains-mono-nerd

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

    pipewire
    pipewire-pulse
    pipewire-alsa
    wireplumber

    networkmanager
     
    blueman 
    bluez
    bluez-utils

    tlp

    git
    base-devel

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
# Pacman
################################################################################

log "Updating system..."

sudo pacman -Syu --noconfirm

log "Installing pacman packages..."

sudo pacman -S \
    --needed \
    --noconfirm \
    "${PACMAN_PACKAGES[@]}"

################################################################################
# yay
################################################################################

if ! command -v yay >/dev/null; then

    log "Installing yay..."

    TMPDIR="$(mktemp -d)"

    git clone https://aur.archlinux.org/yay.git "$TMPDIR"

    pushd "$TMPDIR" >/dev/null

    makepkg -si --noconfirm

    popd >/dev/null

else

    success "yay already installed."

fi

################################################################################
# AUR
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

if command -v flatpak >/dev/null; then

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

else

    warn "Flatpak not installed."

fi

################################################################################
# Services
################################################################################

enable_service() {

    local service="$1"

    if systemctl list-unit-files | grep -q "^${service}"; then

        sudo systemctl enable --now "$service"

        success "$service enabled."

    else

        warn "$service not found."

    fi

}

log "Enabling services..."

enable_service "tlp.service"
enable_service "NetworkManager.service"
enable_service "bluetooth.service"

################################################################################
# Finished
################################################################################

echo
success "All packages installed successfully."

echo
echo "You can now continue with the configuration installation."
