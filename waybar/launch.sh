#! /bin/bash
#shebang
pkill waybar

waybar &


pkill swaync && swaync &
