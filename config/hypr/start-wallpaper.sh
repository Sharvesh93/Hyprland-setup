#!/usr/bin/env bash

sleep 0.2 

dir=~/Pictures/Wallpapers

exec /usr/bin/mpvpaper \
    -o "--loop --hwdec=auto --vf=fps=30" \
    ALL \
    $dir/rei.mp4
