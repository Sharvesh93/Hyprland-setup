#!/usr/bin/env bash

cat <<EOF | rofi -dmenu \
-theme ~/.config/rofi/theme.rasi \
-no-custom \
-p "󰌌  Keybindings"
  SUPER + T      Terminal
  SUPER + E      File Manager
󰍉  SUPER + Space  App Launcher
  SUPER + W      Wallpaper Menu
  SUPER + S      Area Screenshot
󰹑  SUPER + Print  Full Screenshot
  SUPER + A      Brave
󰨞  SUPER + C      VS Code
  SUPER + L      Lock Screen
󰂚  SUPER + N      Notifications
EOF
