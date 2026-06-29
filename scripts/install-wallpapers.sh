#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Installing wallpapers..."

mkdir -p ~/Pictures/Wallpapers

cp -r "$SCRIPT_DIR/Wallpapers/"* ~/Pictures/Wallpapers/