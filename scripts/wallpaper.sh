#!/usr/bin/env bash

set -Eeuo pipefail

################################################################################
# Configuration
################################################################################

WALL_DIR="$HOME/Pictures/Wallpapers"

ROFI_DIR="$HOME/.config/rofi"
ROFI_THEME="config"

################################################################################
# Logging
################################################################################

notify() {
    command -v notify-send >/dev/null &&
        notify-send "Wallpaper" "$1"
}

warn() {
    notify "Warning: $1"
}

################################################################################
# Checks
################################################################################

[[ -d "$WALL_DIR" ]] || {
    notify "Wallpaper directory not found."
    exit 1
}

command -v awww >/dev/null || {
    notify "awww is not installed."
    exit 1
}

################################################################################
# Read wallpapers
################################################################################

mapfile -d '' wallpapers < <(

find "$WALL_DIR" \
    -type f \
    \( \
        -iname "*.jpg" \
        -o -iname "*.jpeg" \
        -o -iname "*.png" \
        -o -iname "*.webp" \
        -o -iname "*.bmp" \
    \) \
    -print0

)

(( ${#wallpapers[@]} )) || {
    notify "No wallpapers found."
    exit 1
}

################################################################################
# Wallpaper selection
################################################################################

case "${1:-rofi}" in

random)

    wallpaper="${wallpapers[RANDOM % ${#wallpapers[@]}]}"

    ;;

rofi)

    command -v rofi >/dev/null || {
        notify "Rofi not installed."
        exit 1
    }

    selection=$(
        printf "%s\n" "${wallpapers[@]}" |
        sed "s|$WALL_DIR/||" |
        rofi \
            -theme "$ROFI_DIR/$ROFI_THEME.rasi" \
            -dmenu \
            -i \
            -p "Wallpaper"
    )

    [[ -n "$selection" ]] || exit 0

    wallpaper="$WALL_DIR/$selection"

    ;;

*)

    echo "Usage:"
    echo "wallpaper [random|rofi]"
    exit 1

    ;;

esac

################################################################################
# Wallpaper transition
################################################################################

duration=$(awk 'BEGIN{
    srand()
    printf "%.1f\n",0.8+rand()*1.7
}')

angle=$(( RANDOM % 360 ))

################################################################################
# Change wallpaper
################################################################################

awww img \
    "$wallpaper" \
    --transition-type random \
    --transition-duration "$duration" \
    --transition-angle "$angle" \
    --transition-fps 60

################################################################################
# Matugen
################################################################################

if command -v matugen >/dev/null; then

    matugen image \
        "$wallpaper" \
        --mode dark \
        --source-color-index 0 \
        --quiet

fi

################################################################################
# Reload components
################################################################################

command -v hyprctl >/dev/null &&
    hyprctl reload || true

pkill waybar >/dev/null 2>&1 || true

command -v waybar >/dev/null &&
    waybar >/dev/null 2>&1 &

command -v swaync-client >/dev/null &&
    swaync-client -rs || true

command -v kitty >/dev/null &&
    kitty @ load-config >/dev/null 2>&1 || true

################################################################################
# Notification
################################################################################

notify "Wallpaper changed successfully."