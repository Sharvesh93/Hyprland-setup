#!/usr/bin/env bash
cap=$(cat /sys/class/power_supply/BAT1/capacity 2>/dev/null || echo "100")
stat=$(cat /sys/class/power_supply/BAT1/status 2>/dev/null || echo "Full")
if [[ "$stat" == "Charging" ]]; then
    icon="󰂄"
elif [[ "$cap" -ge 80 ]]; then
    icon="󰂂"
elif [[ "$cap" -ge 50 ]]; then
    icon="󰁾"
elif [[ "$cap" -ge 20 ]]; then
    icon="󰁼"
else
    icon="󰁺"
fi
echo "$icon $cap%"
