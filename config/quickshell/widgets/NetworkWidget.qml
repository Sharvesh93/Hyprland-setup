import QtQuick
import "../themes"
import "../services"

Rectangle {
    id: root
    height: 18
    width: contentRow.width + 10
    radius: 9
    color: mouseArea.containsMouse ? Colors.cardBgHover : Colors.cardBg

    Behavior on color {
        ColorAnimation { duration: Theme.animDurationFast }
    }

    readonly property string icon: {
        if (!NetworkService.connected) return "󰤮";
        if (NetworkService.signal > 75) return "󰤨";
        if (NetworkService.signal > 50) return "󰤥";
        if (NetworkService.signal > 25) return "󰤢";
        return "󰤟";
    }

    Row {
        id: contentRow
        anchors.centerIn: parent
        spacing: 4

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: root.icon
            font.family: Theme.fontFamily
            font.pixelSize: 10
            color: NetworkService.connected ? Colors.primary : Colors.error
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: NetworkService.connected ? NetworkService.ssid : "Offline"
            font.family: Theme.fontFamily
            font.pixelSize: 10
            font.weight: Theme.fontWeightMedium
            color: Colors.textColor
            elide: Text.ElideRight
            maximumLineCount: 1
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
    }
}
