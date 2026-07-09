#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Installing wallpapers..."

mkdir -p ~/Pictures/Wallpapers

cp -r "$SCRIPT_DIR/Wallpapers/"* ~/Pictures/Wallpapers/

awww img ~/Pictures/Wallpapers/the_girl.jpg

matugen image  ~/Pictures/Wallpapers/the_girl.jpg\
    --mode dark \
    --source-color-index 0 \
    --quiet

mkdir -p ~/.local/bin

mv wallpaper.sh ~/.local/bin/wallpaper.sh

chmod +x ~/.local/bin/wallpaper.sh