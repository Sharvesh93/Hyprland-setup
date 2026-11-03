import QtQuick
import "../themes"
import "../services"

Rectangle {
    id: root
    height: 24
    width: contentRow.width + 14
    radius: 12
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
        spacing: 5

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: root.icon
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSizeNormal
            color: NetworkService.connected ? Colors.primary : Colors.error
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: NetworkService.connected ? NetworkService.ssid : "Offline"
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSizeSmall
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
