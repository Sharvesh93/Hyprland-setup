import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "../themes"
import "../services"

PanelWindow {
    id: root

    anchors {
        top: true
        right: true
    }

    implicitWidth: 300
    implicitHeight: card.height
    color: "transparent"
    visible: NotificationService.visibleToast && NotificationService.currentNotification !== null

    margins {
        top: Theme.barHeight + (Theme.barMarginTop * 2) + 6
        right: Theme.barMarginSide
    }

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "quickshell-toast"
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.None

    Rectangle {
        id: card
        width: parent.width
        implicitHeight: contentCol.implicitHeight + 16
        radius: Theme.radiusNormal
        color: Colors.cardBg

        ColumnLayout {
            id: contentCol
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                margins: 8
            }
            spacing: 3

            // Header: App name and functional Close button
            RowLayout {
                Layout.fillWidth: true

                Text {
                    text: NotificationService.currentNotification ? NotificationService.currentNotification.appName : ""
                    font.family: Theme.fontFamily
                    font.pixelSize: Theme.fontSizeSmall
                    font.weight: Theme.fontWeightMedium
                    color: Colors.primary
                    elide: Text.ElideRight
                }

                Item { Layout.fillWidth: true }

                // Functional Close Button with clear label and icon
                Rectangle {
                    id: closeBtn
                    width: closeRow.width + 10
                    height: 18
                    radius: Theme.radiusSmall
                    color: closeMouse.containsMouse ? Colors.cardBgHover : Colors.inactivePillBg

                    Row {
                        id: closeRow
                        anchors.centerIn: parent
                        spacing: 3

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            text: "󰅖"
                            font.family: Theme.fontFamily
                            font.pixelSize: 10
                            color: closeMouse.containsMouse ? Colors.primary : Colors.textSecondary
                        }

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            text: "Close"
                            font.family: Theme.fontFamily
                            font.pixelSize: 9
                            font.weight: Theme.fontWeightMedium
                            color: closeMouse.containsMouse ? Colors.primary : Colors.textSecondary
                        }
                    }

                    MouseArea {
                        id: closeMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            NotificationService.dismiss();
                        }
                    }
                }
            }

            // Summary (e.g. "Config reloaded") - Semibold for headings
            Text {
                Layout.fillWidth: true
                text: NotificationService.currentNotification ? NotificationService.currentNotification.summary : ""
                font.family: Theme.fontFamily
                font.pixelSize: Theme.fontSizeNormal
                font.weight: Theme.fontWeightSemiBold
                color: Colors.textColor
                wrapMode: Text.Wrap
                maximumLineCount: 2
                elide: Text.ElideRight
            }

            // Body - Regular for normal text
            Text {
                Layout.fillWidth: true
                text: NotificationService.currentNotification ? NotificationService.currentNotification.body : ""
                font.family: Theme.fontFamily
                font.pixelSize: Theme.fontSizeSmall
                font.weight: Theme.fontWeightRegular
                color: Colors.textSecondary
                wrapMode: Text.Wrap
                maximumLineCount: 3
                elide: Text.ElideRight
                visible: text.length > 0
            }
        }

        // Clicking anywhere on card background also dismisses
        MouseArea {
            anchors.fill: parent
            z: -1
            cursorShape: Qt.PointingHandCursor
            onClicked: NotificationService.dismiss()
        }
    }
}
