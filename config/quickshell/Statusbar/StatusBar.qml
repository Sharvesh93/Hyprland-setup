import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

// Aesthetic top bar: workspaces + focused window on the left, clock in the
// middle, hardware/media status on the right.
PanelWindow {
    id: bar

    property QtObject theme: null

    signal openWallpaper()

    anchors {
        top: true
        left: true
        right: true
    }
    implicitHeight: 46
    exclusiveZone: 46
    aboveWindows: true
    color: "transparent"

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    Poller {
        id: volume
        interval: 1500
        command: "wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null || echo 'Volume: 0'"
    }

    Poller {
        id: battery
        interval: 5000
        command: "set -- /sys/class/power_supply/BAT*; if [ -f \"$1/capacity\" ]; then printf '%s %s' \"$(cat \"$1/capacity\")\" \"$(cat \"$1/status\")\"; else echo '100 Full'; fi"
    }

    Poller {
        id: network
        interval: 5000
        command: "nmcli -t -f NAME connection show --active 2>/dev/null | head -n1 || true"
    }

    Poller {
        id: bluetooth
        interval: 5000
        command: "timeout 2 bluetoothctl show 2>/dev/null | grep -q 'Powered: yes' && echo on || echo off"
    }

    Poller {
        id: media
        interval: 3000
        command: "timeout 2 playerctl metadata --format '{{title}} - {{artist}}' 2>/dev/null || true"
    }

    property bool muted: volume.value.includes("[MUTED]")
    property int volumePercent: {
        const n = parseFloat(volume.value.replace(/[^0-9.]/g, ""))
        return isNaN(n) ? 0 : Math.round(n * 100)
    }
    property string batteryRaw: battery.value || "100 Full"
    property string batteryPercent: batteryRaw.split(" ")[0] || "100"
    property bool charging: batteryRaw.includes("Charging")
    property string netName: network.value || "offline"

    // Floating glass surface.
    Rectangle {
        anchors.fill: parent
        anchors.margins: 6
        radius: 16
        color: bar.theme ? bar.theme.barBg : "#111318"
        border.width: 1
        border.color: Qt.rgba(1, 1, 1, 0.07)
    }

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 18
        anchors.rightMargin: 18
        spacing: 12

        // Workspaces.
        Row {
            spacing: 6
            Layout.alignment: Qt.AlignVCenter

            Repeater {
                model: Hyprland.workspaces ? Hyprland.workspaces : []

                delegate: Rectangle {
                    width: 28
                    height: 28
                    radius: 9
                    color: modelData.focused
                        ? Qt.rgba((bar.theme ? bar.theme.primary.r : 0.64),
                                  (bar.theme ? bar.theme.primary.g : 0.79),
                                  (bar.theme ? bar.theme.primary.b : 1.0), 0.22)
                        : Qt.rgba(1, 1, 1, 0.05)
                    border.width: 1
                    border.color: modelData.focused
                        ? (bar.theme ? bar.theme.primary : "#a3c9fe")
                        : "transparent"

                    Text {
                        anchors.centerIn: parent
                        text: modelData.name || String(modelData.id)
                        color: modelData.focused
                            ? (bar.theme ? bar.theme.primary : "#a3c9fe")
                            : (bar.theme ? bar.theme.textSecondary : "#c3c6cf")
                        font.family: "Iosevka Nerd Font"
                        font.pixelSize: 12
                        font.bold: modelData.focused
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: Hyprland.dispatch("workspace " + modelData.id)
                    }
                }
            }
        }

        // Focused window title.
        Text {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter
            text: Hyprland.activeToplevel && Hyprland.activeToplevel.title
                ? Hyprland.activeToplevel.title
                : "Hyprland"
            color: bar.theme ? bar.theme.textColor : "#e1e2e8"
            font.family: "Iosevka Nerd Font"
            font.pixelSize: 13
            elide: Text.ElideRight
        }

        // Date + time.
        Row {
            spacing: 8
            Layout.alignment: Qt.AlignVCenter

            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: clock.date.toLocaleDateString(Qt.locale(), "ddd dd MMM")
                color: bar.theme ? bar.theme.textSecondary : "#c3c6cf"
                font.family: "Iosevka Nerd Font"
                font.pixelSize: 12
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: clock.date.toLocaleTimeString(Qt.locale(), "HH:mm")
                color: bar.theme ? bar.theme.textColor : "#e1e2e8"
                font.family: "Iosevka Nerd Font"
                font.pixelSize: 14
                font.bold: true
            }
        }

        Pill {
            theme: bar.theme
            icon: "♪"
            label: media.value
            accent: bar.theme ? bar.theme.secondary : "#c9b6ff"
            maxLabelWidth: 180
        }

        Pill {
            theme: bar.theme
            icon: bar.muted ? "⊘" : "♪"
            label: bar.muted ? "muted" : bar.volumePercent + "%"
            accent: bar.muted ? (bar.theme ? bar.theme.error : "#ffb4ab")
                              : (bar.theme ? bar.theme.primary : "#a3c9fe")
        }

        Pill {
            theme: bar.theme
            icon: "▰"
            label: bar.batteryPercent + "%"
            accent: bar.charging ? "#7ad9a8" : (bar.theme ? bar.theme.secondary : "#c9b6ff")
        }

        Pill {
            theme: bar.theme
            icon: "≋"
            label: bar.netName
            accent: "#7ad9a8"
            maxLabelWidth: 140
        }

        Pill {
            theme: bar.theme
            icon: "ᛒ"
            label: bluetooth.value === "on" ? "on" : "off"
            accent: "#89b4fa"
        }

        Pill {
            theme: bar.theme
            icon: "▣"
            label: "Wallpaper"
            accent: bar.theme ? bar.theme.primary : "#a3c9fe"
            onClicked: bar.openWallpaper()
        }
    }
}
