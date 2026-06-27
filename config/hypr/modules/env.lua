hl.env("XCURSOR_SIZE", "20")
hl.env("HYPRCURSOR_SIZE", "20")
hl.env("HYPRCURSOR_THEM","catppuccin-macchiato-lavender-cursors")
hl.env("XCURSOR_THEME","catppuccin-macchiato-lavender-cursors")
-- Toolkit backend
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
