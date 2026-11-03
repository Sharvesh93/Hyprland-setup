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
        if (AudioService.muted || AudioService.volume === 0) return "󰝟";
        if (AudioService.volume < 30) return "󰕿";
        if (AudioService.volume < 70) return "󰖀";
        return "󰕾";
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
            color: AudioService.muted ? Colors.error : Colors.primary
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: AudioService.muted ? "Mute" : AudioService.volume + "%"
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSizeSmall
            color: AudioService.muted ? Colors.textTertiary : Colors.textColor
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: AudioService.toggleMute()
        onWheel: wheel => {
            if (wheel.angleDelta.y > 0) {
                AudioService.setVolume(AudioService.volume + 5);
            } else if (wheel.angleDelta.y < 0) {
                AudioService.setVolume(AudioService.volume - 5);
            }
        }
    }
}
