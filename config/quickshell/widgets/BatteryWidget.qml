import QtQuick
import "../themes"
import "../services"

Rectangle {
    id: root
    visible: BatteryService.hasBattery
    height: 18
    width: contentRow.width + 10
    radius: 9
    color: Colors.cardBg

    readonly property string icon: {
        if (BatteryService.isCharging) return "󰂄";
        var p = BatteryService.percentage;
        if (p >= 90) return "󰁹";
        if (p >= 75) return "󰂁";
        if (p >= 50) return "󰁿";
        if (p >= 25) return "󰁽";
        if (p >= 10) return "󰁻";
        return "󰁺";
    }

    readonly property color iconColor: {
        if (BatteryService.isCharging) return Colors.tertiary;
        if (BatteryService.percentage <= 20) return Colors.error;
        return Colors.primary;
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
            color: root.iconColor
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: BatteryService.percentage + "%"
            font.family: Theme.fontFamily
            font.pixelSize: 10
            font.weight: Theme.fontWeightMedium
            color: Colors.textColor
        }
    }
}
