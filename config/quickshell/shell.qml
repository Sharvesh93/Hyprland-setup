import QtQuick
import Quickshell
import Quickshell.Io
import "Statusbar"
import "Wallpaper"

// This is the default Quickshell config: it is picked up by plain `quickshell`
// from ~/.config/quickshell/shell.qml.
ShellRoot {
    id: shell

    property bool pickerOpen: false
    property string currentWallpaper: ""

    // Static fallback palette. Matugen writes colors.json on every wallpaper
    // change and the poller below updates these properties in place, so no
    // shell restart is required.
    QtObject {
        id: theme
        property color background: "#111318"
        property color surface: "#181b21"
        property color surfaceContainer: "#1d2024"
        property color surfaceContainerHighest: "#32353a"
        property color primary: "#a3c9fe"
        property color secondary: "#c9b6ff"
        property color textColor: "#e1e2e8"
        property color textSecondary: "#c3c6cf"
        property color outline: "#8d9199"
        property color error: "#ffb4ab"
        property color barBg: Qt.rgba(0.07, 0.08, 0.10, 0.78)
        property color cardBg: Qt.rgba(0.08, 0.09, 0.12, 0.94)
    }

    Process {
        id: themeProc
        command: ["sh", "-c", "cat \"$HOME/.config/quickshell/themes/colors.json\" 2>/dev/null || true"]
        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    const c = JSON.parse(this.text)
                    if (c.background) theme.background = c.background
                    if (c.surface) theme.surface = c.surface
                    if (c.surface_container) theme.surfaceContainer = c.surface_container
                    if (c.primary) theme.primary = c.primary
                    if (c.secondary) theme.secondary = c.secondary
                    if (c.text) theme.textColor = c.text
                    if (c.text_secondary) theme.textSecondary = c.text_secondary
                    if (c.outline) theme.outline = c.outline
                    if (c.error) theme.error = c.error
                    theme.barBg = Qt.rgba(theme.surface.r, theme.surface.g, theme.surface.b, 0.78)
                    theme.cardBg = Qt.rgba(theme.surface.r, theme.surface.g, theme.surface.b, 0.94)
                } catch (e) {
                    // Keep the fallback palette if the file is incomplete.
                }
            }
        }
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            themeProc.running = false
            themeProc.running = true
        }
    }

    Component.onCompleted: themeProc.running = true

    // `qs ipc call wallpaper <function>` from Hyprland keybindings.
    IpcHandler {
        target: "wallpaper"

        function toggle() {
            shell.pickerOpen = !shell.pickerOpen
        }

        function open() {
            shell.pickerOpen = true
        }

        function close() {
            shell.pickerOpen = false
        }

        function random() {
            picker.applyRandom()
        }

        function refresh_theme() {
            themeProc.running = false
            themeProc.running = true
        }
    }

    StatusBar {
        theme: theme
        onOpenWallpaper: shell.pickerOpen = true
    }

    WallpaperPicker {
        id: picker
        theme: theme
        open: shell.pickerOpen
        onDismiss: shell.pickerOpen = false
        onApplied: {
            shell.currentWallpaper = path
            shell.pickerOpen = false
        }
    }
}
