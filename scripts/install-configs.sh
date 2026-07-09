#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Installing configs..."

mkdir -p ~/.config

cp -r "$SCRIPT_DIR/config/"* ~/.config/


ln -sfn ~/.config/matugen/generated ~/.config/hypr/themes/generated