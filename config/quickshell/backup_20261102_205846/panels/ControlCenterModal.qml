import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import "../themes"
import "../services"

PanelWindow {
    id: root

    anchors {
        top: true
        right: true
    }

    implicitWidth: 320
    implicitHeight: 340
    color: "transparent"
    visible: false

    margins {
        top: Theme.barHeight + Theme.barMarginTop + 6
        right: Theme.barMarginSide
    }

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "quickshell-cc"
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.None

    function toggle() {
        root.visible = !root.visible;
    }

    function close() {
        root.visible = false;
    }

    Rectangle {
        id: card
        anchors.fill: parent
        radius: Theme.radiusLarge
        color: Colors.cardBg

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 14
            spacing: 12

            // Header: Quick Settings title & close
            RowLayout {
                Layout.fillWidth: true

                Text {
                    text: "Quick Controls"
                    font.family: Theme.fontFamily
                    font.pixelSize: Theme.fontSizeNormal
                    font.bold: true
                    color: Colors.textColor
                }

                Item { Layout.fillWidth: true }

                Rectangle {
                    width: 22
                    height: 22
                    radius: 11
                    color: closeMouse.containsMouse ? Colors.cardBgHover : "transparent"

                    Text {
                        anchors.centerIn: parent
                        text: "󰅖"
                        font.family: Theme.fontFamily
                        font.pixelSize: Theme.fontSizeSmall
                        color: Colors.textSecondary
                    }

                    MouseArea {
                        id: closeMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: root.close()
                    }
                }
            }

            // Quick Toggle Tiles (2x2 grid)
            GridLayout {
                Layout.fillWidth: true
                columns: 2
                rowSpacing: 8
                columnSpacing: 8

                // Audio Mute toggle tile
                Rectangle {
                    Layout.fillWidth: true
                    height: 42
                    radius: Theme.radiusNormal
                    color: AudioService.muted ? Colors.inactivePillBg : Colors.activePillBg

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 8
                        spacing: 8

                        Text {
                            text: AudioService.muted ? "󰝟" : "󰕾"
                            font.family: Theme.fontFamily
                            font.pixelSize: Theme.fontSizeLarge
                            color: AudioService.muted ? Colors.textTertiary : Colors.primary
                        }

                        ColumnLayout {
                            spacing: 1
                            Text {
                                text: AudioService.muted ? "Muted" : "Audio"
                                font.family: Theme.fontFamily
                                font.pixelSize: Theme.fontSizeSmall
                                font.bold: true
                                color: AudioService.muted ? Colors.textTertiary : Colors.textColor
                            }
                            Text {
                                text: AudioService.volume + "%"
                                font.family: Theme.fontFamily
                                font.pixelSize: 10
                                color: Colors.textSecondary
                            }
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: AudioService.toggleMute()
                    }
                }

                // WiFi Status Tile
                Rectangle {
                    Layout.fillWidth: true
                    height: 42
                    radius: Theme.radiusNormal
                    color: NetworkService.connected ? Colors.activePillBg : Colors.inactivePillBg

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 8
                        spacing: 8

                        Text {
                            text: NetworkService.connected ? "󰤨" : "󰤮"
                            font.family: Theme.fontFamily
                            font.pixelSize: Theme.fontSizeLarge
                            color: NetworkService.connected ? Colors.primary : Colors.textTertiary
                        }

                        ColumnLayout {
                            spacing: 1
                            Text {
                                text: "Wi-Fi"
                                font.family: Theme.fontFamily
                                font.pixelSize: Theme.fontSizeSmall
                                font.bold: true
                                color: NetworkService.connected ? Colors.textColor : Colors.textTertiary
                            }
                            Text {
                                text: NetworkService.connected ? NetworkService.ssid : "Disconnected"
                                font.family: Theme.fontFamily
                                font.pixelSize: 10
                                color: Colors.textSecondary
                                elide: Text.ElideRight
                                Layout.maximumWidth: 80
                            }
                        }
                    }
                }

                // Random Wallpaper Tile
                Rectangle {
                    Layout.fillWidth: true
                    height: 42
                    radius: Theme.radiusNormal
                    color: randWallMouse.containsMouse ? Colors.cardBgHover : Colors.inactivePillBg

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 8
                        spacing: 8

                        Text {
                            text: "󰸉"
                            font.family: Theme.fontFamily
                            font.pixelSize: Theme.fontSizeLarge
                            color: Colors.secondary
                        }

                        Text {
                            text: "Next Wall"
                            font.family: Theme.fontFamily
                            font.pixelSize: Theme.fontSizeSmall
                            color: Colors.textColor
                        }
                    }

                    MouseArea {
                        id: randWallMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            runCmdProc.command = ["sh", "-c", Quickshell.env("HOME") + "/.local/bin/rice-theme.sh random"];
                            runCmdProc.running = true;
                        }
                    }
                }

                // Wallpaper Picker Tile
                Rectangle {
                    Layout.fillWidth: true
                    height: 42
                    radius: Theme.radiusNormal
                    color: selWallMouse.containsMouse ? Colors.cardBgHover : Colors.inactivePillBg

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 8
                        spacing: 8

                        Text {
                            text: "󰏘"
                            font.family: Theme.fontFamily
                            font.pixelSize: Theme.fontSizeLarge
                            color: Colors.tertiary
                        }

                        Text {
                            text: "Pick Wall"
                            font.family: Theme.fontFamily
                            font.pixelSize: Theme.fontSizeSmall
                            color: Colors.textColor
                        }
                    }

                    MouseArea {
                        id: selWallMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            root.close();
                            runCmdProc.command = ["sh", "-c", Quickshell.env("HOME") + "/.local/bin/rice-theme.sh select"];
                            runCmdProc.running = true;
                        }
                    }
                }
            }

            // Volume Slider Row
            RowLayout {
                Layout.fillWidth: true
                spacing: 8

                Text {
                    text: "󰕾"
                    font.family: Theme.fontFamily
                    font.pixelSize: Theme.fontSizeNormal
                    color: Colors.primary
                }

                Slider {
                    id: volSlider
                    Layout.fillWidth: true
                    from: 0
                    to: 100
                    value: AudioService.volume
                    onMoved: AudioService.setVolume(value)
                }

                Text {
                    text: Math.round(AudioService.volume) + "%"
                    font.family: Theme.fontFamily
                    font.pixelSize: 10
                    color: Colors.textSecondary
                    Layout.preferredWidth: 30
                }
            }

            // Brightness Slider Row
            RowLayout {
                Layout.fillWidth: true
                spacing: 8

                Text {
                    text: "󰃠"
                    font.family: Theme.fontFamily
                    font.pixelSize: Theme.fontSizeNormal
                    color: Colors.primary
                }

                Slider {
                    id: briSlider
                    Layout.fillWidth: true
                    from: 5
                    to: 100
                    value: BrightnessService.brightness
                    onMoved: BrightnessService.setBrightness(value)
                }

                Text {
                    text: Math.round(BrightnessService.brightness) + "%"
                    font.family: Theme.fontFamily
                    font.pixelSize: 10
                    color: Colors.textSecondary
                    Layout.preferredWidth: 30
                }
            }

            Item { Layout.fillHeight: true }

            // Bottom session row: Lock, Exit, Reboot, Power
            RowLayout {
                Layout.fillWidth: true
                spacing: 6

                Repeater {
                    model: [
                        { icon: "󰌾", action: "hyprlock" },
                        { icon: "󰗽", action: "hyprctl dispatch exit" },
                        { icon: "󰜉", action: "systemctl reboot" },
                        { icon: "󰐥", action: "systemctl poweroff" }
                    ]

                    Rectangle {
                        id: sessionBtn
                        required property var modelData

                        Layout.fillWidth: true
                        height: 32
                        radius: Theme.radiusSmall
                        color: sMouse.containsMouse ? Colors.cardBgHover : Colors.inactivePillBg

                        Text {
                            anchors.centerIn: parent
                            text: sessionBtn.modelData.icon
                            font.family: Theme.fontFamily
                            font.pixelSize: Theme.fontSizeMedium
                            color: Colors.textColor
                        }

                        MouseArea {
                            id: sMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                runCmdProc.command = ["sh", "-c", sessionBtn.modelData.action];
                                runCmdProc.running = true;
                            }
                        }
                    }
                }
            }
        }
    }

    Process {
        id: runCmdProc
        running: false
    }
}
