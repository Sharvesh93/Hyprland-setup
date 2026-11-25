#!/usr/bin/env bash

# Wallpaper helper used by Hyprland keybindings and the Quickshell picker.
#
#   wallpaper.sh init [path]   apply the last/current/default wallpaper (startup)
#   wallpaper.sh set <path>    apply one specific wallpaper (Quickshell picker)
#   wallpaper.sh random        pick a random wallpaper
#   wallpaper.sh rofi          legacy rofi picker

set -Eeuo pipefail

################################################################################
# Configuration
################################################################################

WALL_DIR="${WALLPAPER_DIR:-$HOME/Pictures/Wallpapers}"
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}"
# hyprlock.conf uses the fixed ~/.cache path, so always write there too.
CURRENT_LINK="$HOME/.cache/current_wallpaper"
DEFAULT_WALLPAPER="$WALL_DIR/wallhaven-211xrg.jpg"

################################################################################
# Helpers
################################################################################

notify() {
    if command -v notify-send >/dev/null 2>&1; then
        notify-send "Wallpaper" "$1"
    fi
}

warn() {
    notify "Warning: $1"
    printf 'Warning: %s\n' "$1" >&2
}

die() {
    notify "Error: $1"
    printf 'Error: %s\n' "$1" >&2
    exit 1
}

usage() {
    cat <<'EOF'
Usage: wallpaper.sh <init [path]|set <path>|random|rofi>
EOF
}

list_wallpapers() {
    find "$WALL_DIR" -type f \
        \( \
            -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \
            -o -iname '*.webp' -o -iname '*.bmp' \
        \) -print
}

random_wallpaper() {
    local -a candidates=()
    mapfile -t candidates < <(list_wallpapers | sort)
    ((${#candidates[@]})) || die "No wallpapers found in $WALL_DIR"
    printf '%s\n' "${candidates[RANDOM % ${#candidates[@]}]}"
}

ensure_daemon() {
    command -v awww >/dev/null 2>&1 || die "awww is not installed."
    if ! pgrep -x awww-daemon >/dev/null 2>&1; then
        awww-daemon >/dev/null 2>&1 &
        sleep 1
    fi
}

################################################################################
# Apply
################################################################################

apply_wallpaper() {
    local wallpaper="$1"
    local duration angle

    [[ -f "$wallpaper" ]] || die "Wallpaper not found: $wallpaper"

    # Accept absolute paths or paths relative to the wallpaper directory, but
    # nothing outside of it (the Quickshell picker passes absolute paths).
    [[ "$wallpaper" = /* ]] || wallpaper="$WALL_DIR/$wallpaper"
    case "$wallpaper" in
        "$WALL_DIR"/*) ;;
        *) die "Refusing to use a wallpaper outside $WALL_DIR" ;;
    esac
    [[ -f "$wallpaper" ]] || die "Wallpaper not found: $wallpaper"

    ensure_daemon

    duration="$(awk 'BEGIN{srand(); printf "%.1f", 0.8 + rand() * 1.7}')"
    angle=$((RANDOM % 360))

    if ! awww img "$wallpaper" \
        --transition-type random \
        --transition-duration "$duration" \
        --transition-angle "$angle" \
        --transition-fps 60; then
        die "awww failed to set the wallpaper. Is awww-daemon running?"
    fi

    # hyprlock reads this symlink, so it always matches the active wallpaper.
    mkdir -p "$CACHE_DIR" "$HOME/.cache"
    ln -sfn -- "$wallpaper" "$CURRENT_LINK"

    if command -v matugen >/dev/null 2>&1; then
        if ! matugen image "$wallpaper" \
            --mode dark --source-color-index 0 --quiet; then
            warn "Matugen failed to generate the theme."
        fi
    else
        warn "matugen is not installed; colors will not be regenerated."
    fi

    # Quickshell watches colors.json and refreshes its palette when it changes,
    # but an explicit nudge makes the update instant when the shell is running.
    if command -v qs >/dev/null 2>&1; then
        qs ipc call wallpaper refresh_theme >/dev/null 2>&1 || true
    fi

    notify "Wallpaper changed: $(basename "$wallpaper")"
}

################################################################################
# Entry point
################################################################################

[[ -d "$WALL_DIR" ]] || die "Wallpaper directory not found: $WALL_DIR"

case "${1:-init}" in
    init)
        if [[ -n "${2:-}" ]]; then
            apply_wallpaper "$2"
        elif [[ -e "$CURRENT_LINK" ]]; then
            apply_wallpaper "$(readlink -f -- "$CURRENT_LINK")"
        elif [[ -f "$DEFAULT_WALLPAPER" ]]; then
            apply_wallpaper "$DEFAULT_WALLPAPER"
        else
            apply_wallpaper "$(random_wallpaper)"
        fi
        ;;

    set|apply)
        [[ $# -ge 2 ]] || { usage; exit 1; }
        apply_wallpaper "$2"
        ;;

    random)
        apply_wallpaper "$(random_wallpaper)"
        ;;

    rofi)
        command -v rofi >/dev/null 2>&1 || die "rofi is not installed."
        selection="$(
            list_wallpapers | sort |
            awk -F/ '{ print $NF "\t" $0 }' |
            rofi -dmenu -i -p "Wallpaper"
        )"
        [[ -n "$selection" ]] || exit 0
        apply_wallpaper "$(printf '%s\n' "$selection" | cut -f2-)"
        ;;

    *)
        usage
        exit 1
        ;;
esac
