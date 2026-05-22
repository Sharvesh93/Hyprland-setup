# Hyprland Setup

A curated Hyprland configuration repository for Linux, including Hyprland, Kitty, Rofi, SwayNC, and Waybar configs.

## Contents

- `hypr/` - Hyprland configuration files including `hyprland.conf` and `binds.conf`.
- `kitty/` - Kitty terminal emulator configuration.
- `rofi/` - Rofi launcher themes, configuration, and shared launcher scripts.
- `swaync/` - SwayNC notification center configuration and theme files.
- `waybar/` - Waybar status bar configuration and style files.

## Usage

1. Clone or copy this repository into your dotfiles directory.
2. Link or copy the relevant config files into your home configuration paths:
   - `~/.config/hypr/hyprland.conf`
   - `~/.config/hypr/binds.conf`
   - `~/.config/kitty/kitty.conf`
   - `~/.config/rofi/config.rasi`
   - `~/.config/waybar/config.jsonc`
   - `~/.config/waybar/style.css`
   - `~/.config/swaync/config.json`

3. Install any required dependencies for Hyprland, Kitty, Rofi, Waybar, and SwayNC.
4. Reload or restart the session after updating config files.

## Theme & Layout Customization

- `rofi/colors/` contains color theme files for the Rofi launcher.
- `rofi/launchers/` includes multiple launcher styles and a shared script collection.
- `swaync/colors/` contains SwayNC theme files.
- `waybar/colors/` contains color palettes for the bar styling.

## Notes

- This repository is intended to be a configurable Hyprland setup with reusable launcher and panel styles.
- Adjust paths and theme selections based on your environment and preferences.
- Back up your existing configuration before applying changes.

## License

Use the configs as a starting point for your own setup. Modify freely where needed.
