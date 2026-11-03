import QtQuick
import "../themes"
import "../services"

Rectangle {
    id: root
    height: 24
    width: contentRow.width + 14
    radius: 12
    color: Colors.cardBg

    Row {
        id: contentRow
        anchors.centerIn: parent
        spacing: 5

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: "󰍛"
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSizeNormal
            color: Colors.secondary
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: SysmonService.ramPercent + "%"
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSizeSmall
            color: Colors.textColor
        }
    }
}
