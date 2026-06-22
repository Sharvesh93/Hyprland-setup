#!/bin/bash

sudo pacman -S --needed base-devel \
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



# -------------- Copy the folders ----------------
cp -r hypr ~/.config/
cp -r kitty ~/.config/
cp -r nvim ~/.config/
cp -r rofi ~/.config/

