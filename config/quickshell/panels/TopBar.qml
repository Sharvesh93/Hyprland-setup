import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "../themes"
import "../widgets"
import "../services"

PanelWindow {
    id: root

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: Theme.barHeight + (Theme.barMarginTop * 2)
    exclusiveZone: implicitHeight
    color: "transparent"

    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.namespace: "quickshell-bar"

    signal toggleLauncher()
    signal toggleControlCenter()

    Rectangle {
        id: barContainer
        anchors {
            fill: parent
            topMargin: Theme.barMarginTop
            bottomMargin: Theme.barMarginTop
            leftMargin: Theme.barMarginSide
            rightMargin: Theme.barMarginSide
        }
        radius: Theme.radiusLarge
        color: Colors.barBg

        Item {
            anchors.fill: parent
            anchors.leftMargin: 8
            anchors.rightMargin: 8

            // --- Left Section: Launcher & Workspaces ---
            Row {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                spacing: 8

                // App Launcher trigger button
                Rectangle {
                    width: 20
                    height: 20
                    radius: 10
                    color: launcherBtnMouse.containsMouse ? Colors.cardBgHover : Colors.cardBg
                    anchors.verticalCenter: parent.verticalCenter

                    Text {
                        anchors.centerIn: parent
                        text: "󱓞"
                        font.family: Theme.fontFamily
                        font.pixelSize: Theme.fontSizeMedium
                        color: Colors.primary
                    }

                    MouseArea {
                        id: launcherBtnMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: root.toggleLauncher()
                    }
                }

                // Workspace switcher
                WorkspaceWidget {
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            // --- Center Section: Clock & Date ---
            ClockWidget {
                anchors.centerIn: parent
            }

            // --- Right Section: System Status & Controls ---
            Row {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                spacing: 6

                SysmonWidget {
                    anchors.verticalCenter: parent.verticalCenter
                }

                AudioWidget {
                    anchors.verticalCenter: parent.verticalCenter
                }

                NetworkWidget {
                    anchors.verticalCenter: parent.verticalCenter
                }

                BatteryWidget {
                    anchors.verticalCenter: parent.verticalCenter
                }

                TrayWidget {
                    anchors.verticalCenter: parent.verticalCenter
                }

                // Control Center trigger button
                Rectangle {
                    width: 20
                    height: 20
                    radius: 10
                    color: ccBtnMouse.containsMouse ? Colors.cardBgHover : Colors.cardBg
                    anchors.verticalCenter: parent.verticalCenter

                    Text {
                        anchors.centerIn: parent
                        text: "󰒓"
                        font.family: Theme.fontFamily
                        font.pixelSize: Theme.fontSizeSmall
                        color: Colors.primary
                    }

                    MouseArea {
                        id: ccBtnMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: root.toggleControlCenter()
                    }
                }
            }
        }
    }
}
