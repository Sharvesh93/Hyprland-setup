import QtQuick
import QtQuick.Layouts
import "../themes"
import "../services"

Row {
    id: root
    spacing: 4

    // Names from Hyprland workspace configuration: 1:web, 2:code, 3:chat, 4:game, 5:design
    readonly property var workspaces: [
        { id: 1, label: "1", name: "web" },
        { id: 2, label: "2", name: "code" },
        { id: 3, label: "3", name: "chat" },
        { id: 4, label: "4", name: "game" },
        { id: 5, label: "5", name: "design" }
    ]

    Repeater {
        model: root.workspaces

        Rectangle {
            id: item
            required property var modelData

            readonly property bool isActive: HyprlandService.activeWorkspace === modelData.id
            readonly property bool isOccupied: HyprlandService.isOccupied(modelData.id)

            width: isActive ? 22 : (isOccupied ? 14 : 7)
            height: 14
            radius: 7

            color: isActive ? Colors.primary : (isOccupied ? Colors.cardBgHover : Colors.inactivePillBg)

            Behavior on width {
                NumberAnimation { duration: Theme.animDurationNormal; easing.type: Easing.OutCubic }
            }
            Behavior on color {
                ColorAnimation { duration: Theme.animDurationFast }
            }

            Text {
                anchors.centerIn: parent
                text: item.modelData.label
                visible: item.isActive || item.isOccupied
                font.family: Theme.fontFamily
                font.pixelSize: 9
                font.weight: item.isActive ? Theme.fontWeightBold : Theme.fontWeightMedium
                color: item.isActive ? Colors.textOnPrimary : Colors.textSecondary
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                onClicked: HyprlandService.switchWorkspace(item.modelData.id)
            }
        }
    }
}
