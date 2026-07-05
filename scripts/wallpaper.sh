#!/usr/bin/env bash

set -euo pipefail

# Wallpaper directory
WALL_DIR="$HOME/Pictures/Wallpapers"

# Rofi configuration
ROFI_DIR="$HOME/.config/rofi"
ROFI_THEME="config"

# Read wallpapers into an array
mapfile -d '' wallpapers < <(
    find "$WALL_DIR" -type f \
    \( \
        -iname "*.jpg" \
        -o -iname "*.jpeg" \
        -o -iname "*.png" \
        -o -iname "*.webp" \
        -o -iname "*.bmp" \
    \) -print0
)

# Exit if no wallpapers exist
[[ ${#wallpapers[@]} -eq 0 ]] && {
    notify-send "Wallpaper" "No wallpapers found!"
    exit 1
}

case "${1:-rofi}" in

    random)
        wallpaper="${wallpapers[RANDOM % ${#wallpapers[@]}]}"
        ;;

    rofi)
        selection=$(
            printf "%s\n" "${wallpapers[@]}" |
            sed "s|$WALL_DIR/||" |
            rofi \
                -theme "$ROFI_DIR/$ROFI_THEME.rasi" \
                -dmenu \
                -i \
                -p "Wallpaper"
        )

        [[ -z "$selection" ]] && exit 0

        wallpaper="$WALL_DIR/$selection"
        ;;

    *)
        echo "Usage: wallpaper.sh [rofi|random]"
        exit 1
        ;;
esac

# Random transition duration (0.8 - 2.5 sec)
duration=$(awk 'BEGIN{srand(); printf "%.1f\n",0.8+rand()*1.7}')

# Random angle
angle=$((RANDOM % 360))

# Change wallpaper
awww img \
    "$wallpaper" \
    --transition-type random \
    --transition-duration "$duration" \
    --transition-angle "$angle" \
    --transition-fps 60


matugen image "$wallpaper" \
    --mode dark \
    --source-color-index 0 \
    --quiet

hyprctl reload

pkill waybar
waybar &

swaync-client -rs

kitty @ load-config

notify-send "Wallpaper Changed " 
