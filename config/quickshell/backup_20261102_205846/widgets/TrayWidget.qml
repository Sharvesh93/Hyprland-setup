import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import "../themes"

Row {
    id: root
    spacing: 6

    readonly property var items: SystemTray.items.values.filter(function(it) {
        var key = ((it.id || "") + " " + (it.title || "")).toLowerCase();
        return !/(nm[ _-]?applet|network[- ]?manager)/.test(key);
    })

    visible: root.items.length > 0

    Repeater {
        model: root.items

        Rectangle {
            id: trayBtn
            required property var modelData

            width: 22
            height: 22
            radius: 6
            color: mouseArea.containsMouse ? Colors.cardBgHover : Colors.cardBg

            Behavior on color {
                ColorAnimation { duration: Theme.animDurationFast }
            }

            IconImage {
                anchors.centerIn: parent
                width: 16
                height: 16
                source: trayBtn.modelData.icon
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: mouse => {
                    if (mouse.button === Qt.LeftButton) {
                        trayBtn.modelData.activate();
                    } else if (mouse.button === Qt.RightButton && trayBtn.modelData.hasMenu) {
                        // Display context menu if available
                        if (trayBtn.modelData.menu) {
                            // Can be triggered
                        }
                    }
                }
            }
        }
    }
}
