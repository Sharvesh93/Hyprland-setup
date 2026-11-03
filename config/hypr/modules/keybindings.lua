-- =========================================================================
-- VARIABLES
-- =========================================================================
local terminal = "kitty"
local fileManager = "nautilus"
local mainMod = "SUPER"

-- =========================================================================
-- SYSTEM & SESSION
-- =========================================================================
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))                           -- Lock Screen
hl.bind("SUPER + Escape", hl.dsp.exec_cmd("~/.config/rofi/scripts/powermenu.sh")) -- Power Menu
hl.bind(
    mainMod .. " + M",
    hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
) -- Exit Session

-- ================================================================
-- QUICKSHELL CONTROLS & IPC
-- ================================================================
-- Custom Quickshell Application Launcher (with fallback to rofi if quickshell is reloading)
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd("quickshell ipc call launcher toggle || rofi -show drun"))
-- Custom Quickshell Control Center / Quick Settings
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("quickshell ipc call control-center toggle"))

-- Wallpaper Picker & Theme switcher
hl.bind(mainMod .. " + Tab", hl.dsp.exec_cmd("~/.local/bin/rice-theme.sh random"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("~/.local/bin/rice-theme.sh select"))

-- =========================================================================
-- APPLICATIONS & LAUNCHERS
-- =========================================================================
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal)) -- Terminal (Kitty)
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))   -- File Explorer
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("zen-browser")) -- Web Browser
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("code"))        -- VS Code
hl.bind(mainMod .. " + U", hl.dsp.exec_cmd("hyprctl keyword monitor HDMI-A-1,preferred,auto,1,mirror,eDP-1"))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("antigravity"))
-- Screenshots
hl.bind(
    mainMod .. " + Print",
    hl.dsp.exec_cmd("mkdir -p ~/Pictures/Screenshots && grim ~/Pictures/Screenshots/$(date +%Y-%m-%d).png")
)
hl.bind(
    mainMod .. " + S",
    hl.dsp.exec_cmd(
        'mkdir -p ~/Pictures/Screenshots && FILE=~/Pictures/Screenshots/$(date "+%Y-%m-%d_%H-%M-%S").png && grim -g "$(slurp -d)" "$FILE" && wl-copy < "$FILE"'
    )
)

-- =========================================================================
-- WINDOW MANAGEMENT
-- =========================================================================
hl.bind(mainMod .. " + Q", hl.dsp.window.close())                      -- Close Window
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())                     -- Pseudo Mode
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))               -- Toggle Split
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())                 -- Full Screen
hl.bind(mainMod .. " + Y", hl.dsp.window.float({ action = "toggle" })) -- Toggle Floating

-- Move Focus
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Swap Windows
hl.bind("SUPER + SHIFT + Left", hl.dsp.window.swap({ direction = "left" }))
hl.bind("SUPER + SHIFT + Right", hl.dsp.window.swap({ direction = "right" }))
hl.bind("SUPER + SHIFT + Up", hl.dsp.window.swap({ direction = "up" }))
hl.bind("SUPER + SHIFT + Down", hl.dsp.window.swap({ direction = "down" }))

-- Mouse Actions (Move/Resize)
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- =========================================================================
-- WORKSPACES
-- =========================================================================
-- Switch and Move (Workspaces 1-10)
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scroll Through Existing Workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- =========================================================================
-- MEDIA & HARDWARE (Always functional at compositor level)
-- =========================================================================
-- Audio Volume & Mute
hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioMicMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true }
)

-- Media Playback (playerctl)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- LCD Brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })
