import QtQuick
import "../themes"

Row {
    id: root
    spacing: 6

    property string timeStr: ""
    property string dateStr: ""

    function updateTime() {
        var d = new Date();
        var h = String(d.getHours()).padStart(2, '0');
        var m = String(d.getMinutes()).padStart(2, '0');
        root.timeStr = h + ":" + m;
        
        var options = { weekday: 'short', month: 'short', day: 'numeric' };
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
        font.pixelSize: Theme.fontSizeSmall
        color: Colors.textSecondary
    }

    Text {
        anchors.verticalCenter: parent.verticalCenter
        text: "•"
        font.family: Theme.fontFamily
        font.pixelSize: 8
        color: Colors.outline
    }

    Text {
        anchors.verticalCenter: parent.verticalCenter
        text: root.timeStr
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSizeMedium
        font.bold: true
        color: Colors.textColor
    }
}
