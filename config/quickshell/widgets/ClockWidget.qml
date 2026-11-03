import QtQuick
import "../themes"

Row {
    id: root
    spacing: 5

    property string timeStr: ""
    property string dateStr: ""

    function updateTime() {
        var d = new Date();
        var h = String(d.getHours()).padStart(2, '0');
        var m = String(d.getMinutes()).padStart(2, '0');
        root.timeStr = h + ":" + m;
        
        root.dateStr = d.toLocaleDateString(Qt.locale(), "ddd, MMM d");
    }

    Component.onCompleted: updateTime()

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: root.updateTime()
    }

    Text {
        anchors.verticalCenter: parent.verticalCenter
        text: root.dateStr
        font.family: Theme.fontFamily
        font.pixelSize: 10
        font.weight: Theme.fontWeightMedium
        color: Colors.textSecondary
    }

    Text {
        anchors.verticalCenter: parent.verticalCenter
        text: "•"
        font.family: Theme.fontFamily
        font.pixelSize: 7
        color: Colors.outline
    }

    Text {
        anchors.verticalCenter: parent.verticalCenter
        text: root.timeStr
        font.family: Theme.fontFamily
        font.pixelSize: 11
        font.weight: Theme.fontWeightBold
        color: Colors.textColor
    }
}
