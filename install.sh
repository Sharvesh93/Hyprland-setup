#!/bin/bash

sudo pacman -S --needed base-devel \
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
        awww \
        fastfetch \
	ttf-jetbrains-mono-nerd \
        grim \
	slurp \
	wl-clipboard \
	hyprlock \
        nwg-look \
        gnome-themes-extra \
	tlp
# -------------- Yay -----------------------------
if ! command -v yay &>/dev/null; then
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
fi

# ------------ Yay Packages------------------------

yay -S --needed \
    ttf-iosevka-nerd 
# -------------- Copy the folders -----------------

mkdir -p ~/.config/hyprland-backup

for dir in hypr kitty waybar rofi swaync nvim do
    [ -d ~/.config/$dir ] && mv ~/.config/$dir ~/.config/hyprland-backup/
done

cp -r hypr ~/.config/
cp -r kitty ~/.config/
cp -r waybar ~/.config/
cp -r rofi ~/.config/
cp -r swaync ~/.config/
cp -r nvim ~/.config/

chmod +x ~/.config/rofi/*
chmod +x ~/.config/waybar/*

mkdir -p ~/.local/bin/

mkdir -p ~/Pictures
cp -r Wallpapers ~/Pictures/ 

mkdir -p ~/.local/bin
cp wallpaper.sh ~/.local/bin/
chmod +x ~/.local/bin/wallpaper.sh

awww img ~/Picture/Wallpapers/Otama.png
