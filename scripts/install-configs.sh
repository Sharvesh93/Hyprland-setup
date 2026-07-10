#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Installing configs..."

mkdir -p ~/.config

shopt -s dotglob nullglob

configs=("$SCRIPT_DIR/config/"*)

(( ${#configs[@]} )) && cp -r "${configs[@]}" ~/.config/

mkdir -p ~/.config/matugen/generated
rm -rf ~/.config/hypr/themes
ln -sfn ~/.config/matugen/generated ~/.config/hypr/themes

echo "Configs installed."
