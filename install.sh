#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

sudo pacman -S --needed base-devel \
        sddm \
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
        swww \
        fastfetch \
	ttf-jetbrains-mono-nerd \
        grim \
	slurp \
	wl-clipboard \
	hyprlock \
        nwg-look \
        gnome-themes-extra \
	tlp --noconfirm

sudo systemctl enable sddm

# -------------- Yay -----------------------------
if ! command -v yay &>/dev/null; then
    [ -d ~/yay ] && rm -rf ~/yay
    git clone https://aur.archlinux.org/yay.git ~/yay
    cd ~/yay
    makepkg -si --noconfirm
    cd -
fi

# ------------ Yay Packages------------------------

yay -S --needed \
    ttf-iosevka-nerd --noconfirm --answerdiff=None --answeredit=None

flatpak install -y flathub com.brave.Browser

flatpak install -y flathub com.visualstudio.code

# -------------- Copy the folders -----------------

mkdir -p ~/.config/hyprland-backup

for dir in hypr kitty waybar rofi swaync nvim; do
    [ -d ~/.config/"$dir" ] && mv ~/.config/"$dir" ~/.config/hyprland-backup/
done

cp -r hypr ~/.config/
cp -r kitty ~/.config/
cp -r waybar ~/.config/
cp -r rofi ~/.config/
cp -r swaync ~/.config/
cp -r nvim ~/.config/

chmod +x ~/.config/rofi/*
chmod +x ~/.config/waybar/*

mkdir -p ~/Pictures
cp -r Wallpapers ~/Pictures/

mkdir -p ~/.local/bin
cp wallpaper.sh ~/.local/bin/
chmod +x ~/.local/bin/wallpaper.sh

echo "Setup complete. System will reboot to apply changes."
read -p "Reboot now? [Y/n] " confirm
if [[ "$confirm" =~ ^[Nn]$ ]]; then
    echo "Skipping reboot. Reboot manually when ready."
else
    reboot
fi