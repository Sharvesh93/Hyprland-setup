import QtQuick

// Wallpaper thumbnail card used by the picker grid.
Rectangle {
    id: root

    property string path: ""
    property bool current: false
    property QtObject theme: null

    signal clicked()

    width: 176
    height: 150
    radius: 14
    clip: true
    color: root.theme ? root.theme.surfaceContainer : "#1d2024"
    border.width: root.current ? 2 : 1
    border.color: root.current
        ? (root.theme ? root.theme.primary : "#a3c9fe")
        : Qt.rgba(1, 1, 1, 0.06)

    Image {
        anchors.fill: parent
        source: encodeURI("file://" + root.path)
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
        cache: true
    }

    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 30
        color: Qt.rgba(0, 0, 0, 0.62)

        Text {
            anchors.fill: parent
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            verticalAlignment: Text.AlignVCenter
            text: root.path.split("/").pop()
            color: "#f5e2c5"
            font.family: "Iosevka Nerd Font"
            font.pixelSize: 11
            elide: Text.ElideRight
        }
    }

    Rectangle {
        visible: root.current
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 8
        width: 18
        height: 18
        radius: 9
        color: root.theme ? root.theme.primary : "#a3c9fe"

        Text {
            anchors.centerIn: parent
            text: "✓"
            color: "#111318"
            font.pixelSize: 11
            font.bold: true
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
}
