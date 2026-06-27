#!/usr/bin/env bash

sudo pacman -Syu --needed --noconfirm \
    base-devel \
    hyprland \
	git \
	neovim \
	fzf \
    kitty \
    flatpak \
	fish \
    nautilus \
    firefox \
    pipewire \
    pipewire-pulse \
    rofi \
    waybar \
    swaync \
	libnotify \
	ttf-jetbrains-mono-nerd \
    grim \
	slurp \
	wl-clipboard \
	hyprlock \
    nwg-look \
    gnome-themes-extra \
	tlp \
    waypaper \
    mpvpaper 

if ! command -v yay &>/dev/null; then
    [ -d ~/yay ] && rm -rf ~/yay
    git clone https://aur.archlinux.org/yay.git ~/yay
    cd ~/yay
    makepkg -si --noconfirm
    cd -
fi

yay -S --needed \
    ttf-iosevka-nerd --noconfirm --answerdiff=None --answeredit=None

flatpak install -y flathub com.brave.Browser
flatpak install -y flathub com.visualstudio.code