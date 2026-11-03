import QtQuick
import "../themes"
import "../services"

Rectangle {
    id: root
    height: 18
    width: contentRow.width + 10
    radius: 9
    color: Colors.cardBg

    Row {
        id: contentRow
        anchors.centerIn: parent
        spacing: 4

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: "󰍛"
            font.family: Theme.fontFamily
            font.pixelSize: 10
            color: Colors.secondary
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: SysmonService.ramPercent + "%"
            font.family: Theme.fontFamily
            font.pixelSize: 10
            font.weight: Theme.fontWeightMedium
            color: Colors.textColor
        }
    }
}
