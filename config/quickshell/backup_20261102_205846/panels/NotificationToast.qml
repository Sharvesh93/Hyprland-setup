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

    implicitWidth: 320
    implicitHeight: card.height
    color: "transparent"
    visible: NotificationService.visibleToast && NotificationService.currentNotification !== null

    margins {
        top: Theme.barHeight + Theme.barMarginTop + 10
        right: Theme.barMarginSide
    }

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "quickshell-toast"
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.None

    Rectangle {
        id: card
        width: parent.width
        implicitHeight: contentCol.implicitHeight + 20
        radius: Theme.radiusNormal
        color: Colors.cardBg

        ColumnLayout {
            id: contentCol
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                margins: 10
            }
            spacing: 4

            RowLayout {
                Layout.fillWidth: true

                Text {
                    text: NotificationService.currentNotification ? NotificationService.currentNotification.appName : ""
                    font.family: Theme.fontFamily
                    font.pixelSize: Theme.fontSizeSmall
                    font.bold: true
                    color: Colors.primary
                    elide: Text.ElideRight
                }

                Item { Layout.fillWidth: true }

                Text {
                    text: "󰅖"
                    font.family: Theme.fontFamily
                    font.pixelSize: 10
                    color: Colors.textTertiary
                }
            }

            Text {
                Layout.fillWidth: true
                text: NotificationService.currentNotification ? NotificationService.currentNotification.summary : ""
                font.family: Theme.fontFamily
                font.pixelSize: Theme.fontSizeNormal
                font.bold: true
                color: Colors.textColor
                wrapMode: Text.Wrap
                maximumLineCount: 2
                elide: Text.ElideRight
            }

            Text {
                Layout.fillWidth: true
                text: NotificationService.currentNotification ? NotificationService.currentNotification.body : ""
                font.family: Theme.fontFamily
                font.pixelSize: Theme.fontSizeSmall
                color: Colors.textSecondary
                wrapMode: Text.Wrap
                maximumLineCount: 3
                elide: Text.ElideRight
                visible: text.length > 0
            }
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: NotificationService.dismiss()
        }
    }
}
