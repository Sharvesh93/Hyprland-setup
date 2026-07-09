#!/usr/bin/env bash

chmod +x ./scripts/*.sh 

if [ "$EUID" -eq 0 ]; then
    echo "Do not run this installer with sudo."
    exit 1
fi

set -e

echo "Installing packages..."
./scripts/install-packages.sh

echo "Backing up existing configs..."
./scripts/backup.sh

echo "Installing configs..."
./scripts/install-configs.sh

echo "Installing wallpapers..."
./scripts/install-wallpapers.sh

echo "Installing zsh configuration..."
cp ./scripts/.zshrc ~/.zshrc

echo "Done."

chmod +x ~/.config/rofi/*
chmod +x ~/.config/waybar/*

echo "Setup complete. System will reboot to apply changes.(Reboot is recommended but not required.)"
read -p "Reboot now? [Y/n] " confirm
if [[ "$confirm" =~ ^[Nn]$ ]]; then
    echo "Skipping reboot. Reboot manually when ready."
else
    reboot
fi