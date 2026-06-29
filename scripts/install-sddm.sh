#!/usr/bin/env bash

set -e

echo "Installing Silent SDDM theme..."

sudo mkdir -p /usr/share/sddm/themes

sudo cp -r sddm/silent /usr/share/sddm/themes/

sudo mkdir -p /etc/sddm.conf.d

sudo tee /etc/sddm.conf.d/theme.conf >/dev/null <<EOF
[Theme]
Current=silent
EOF

echo "Silent SDDM installed."