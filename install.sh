#!/usr/bin/env bash

set -e

# Make all scripts executable
chmod +x ./scripts/*.sh

# Prevent running as root
if [[ "$EUID" -eq 0 ]]; then
    echo "❌ Do not run this installer with sudo."
    exit 1
fi

# Function to run a step safely
run_step() {
    local message="$1"
    shift

    echo
    echo "==> $message"

    if "$@"; then
        echo "✅ Success"
    else
        echo "⚠️ Failed: $message"
    fi
}

# Install packages
run_step "Installing packages..." ./scripts/install-packages.sh

# Backup existing configs
if [[ -d "~/.config" ]]; then
    run_step "Backing up existing configs..." ./scripts/backup.sh
else
    echo "⚠️ backup.sh not found. Skipping."
fi

# Install configs
if [[ -f "./scripts/install-configs.sh" ]]; then
    run_step "Installing configs..." ./scripts/install-configs.sh
else
    echo "⚠️ install-configs.sh not found. Skipping."
fi

# Install wallpapers
if [[ -f "./scripts/install-wallpapers.sh" ]]; then
    run_step "Installing wallpapers..." ./scripts/install-wallpapers.sh
else
    echo "⚠️ install-wallpapers.sh not found. Skipping."
fi

# Install ZSH configuration
if [[ -f "./scripts/.zshrc" ]]; then
    cp ./scripts/.zshrc ~/.zshrc
    echo "✅ Installed .zshrc"
else
    echo "⚠️ .zshrc not found. Skipping."
fi

# Make Rofi scripts executable
if [[ -d ~/.config/rofi ]]; then
    chmod +x ~/.config/rofi/* 2>/dev/null || true
else
    echo "⚠️ ~/.config/rofi not found. Skipping."
fi

# Make Waybar scripts executable
if [[ -d ~/.config/waybar ]]; then
    chmod +x ~/.config/waybar/* 2>/dev/null || true
else
    echo "⚠️ ~/.config/waybar not found. Skipping."
fi

echo
echo "🎉 Setup complete."
echo "A reboot is recommended."

read -rp "Reboot now? [Y/n] " confirm

if [[ "$confirm" =~ ^[Nn]$ ]]; then
    echo "Skipping reboot."
else
    reboot
fi