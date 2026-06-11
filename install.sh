#!/bin/bash

# All the required or currently using packages
os=/etc/os-release
if [ $os = "Arch" ]; then
    sudo pacman -S --needed \
        base-devel \
        git \
        neovim \
        fzf \
        kitty \
        fish \
        nautilus \
        firefox \
        pipewire \
        pipewire-pulse \
        rofi \
        waybar \
        swaync \
        awww \
        fastfetch \
        grim \
        slurp
fi 

# Install yay
if [ ! -d "$HOME/.local/share/yay" ]; then
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si
    cd ..
    rm -rf /tmp/yay
fi

# Install needed drivers for nvidia gpu
if [ $os = "Arch" ]; then
    sudo pacman -S --needed \
        nvidia-open \
        nvidia-utils \
        nvidia-settings
fi
