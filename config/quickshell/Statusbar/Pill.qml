import QtQuick
import QtQuick.Layouts

// Small glass pill used for every status module in the bar.
Rectangle {
    id: root

    property string icon: ""
    property string label: ""
    property QtObject theme: null
    property color accent: theme ? theme.primary : "#a3c9fe"
    property bool active: false
    property int maxLabelWidth: 240

    signal clicked()

    implicitWidth: row.implicitWidth + 24
    implicitHeight: 30
    radius: height / 2
    color: active
        ? Qt.rgba(accent.r, accent.g, accent.b, 0.20)
        : (theme ? theme.cardBg : "#111318")
    border.width: 1
    border.color: active
        ? Qt.rgba(accent.r, accent.g, accent.b, 0.55)
        : Qt.rgba(1, 1, 1, 0.06)

    Behavior on color {
        ColorAnimation { duration: 160 }
    }

    RowLayout {
        id: row
        anchors.centerIn: parent
        spacing: 8

        Text {
            visible: root.icon !== ""
            text: root.icon
            color: root.accent
            font.family: "Iosevka Nerd Font"
            font.pixelSize: 16
            Layout.alignment: Qt.AlignVCenter
        }

        Text {
            visible: root.label !== ""
            text: root.label
            color: root.theme ? root.theme.textColor : "#e1e2e8"
            font.family: "Iosevka Nerd Font"
            font.pixelSize: 13
            elide: Text.ElideRight
            Layout.maximumWidth: root.maxLabelWidth
            Layout.alignment: Qt.AlignVCenter
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
}
