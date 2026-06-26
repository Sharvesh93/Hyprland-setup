#!/usr/bin/env bash

dir="$HOME/.config/rofi/type-1"
theme='rofi' 

pkill rofi || rofi \
    -show drun \
    -theme ${dir}/${theme}.rasi
