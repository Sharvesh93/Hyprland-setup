import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

// Fullscreen Quickshell wallpaper chooser. Toggle it with Super+W or by
// clicking the wallpaper pill in the status bar.
PanelWindow {
    id: root

    property QtObject theme: null
    property bool open: false
    property string searchText: ""
    property string currentPath: ""
    property string pendingPath: ""
    property var wallpapers: []
    property var filtered: root.wallpapers.filter(function(path) {
        return path.toLowerCase().indexOf(root.searchText.toLowerCase()) !== -1
    })

    signal dismiss()
    signal applied(string path)

    anchors {
        left: true
        right: true
        top: true
        bottom: true
    }
    color: "transparent"
    visible: root.open
    focusable: true
    aboveWindows: true
    exclusiveZone: 0

    function shellQuote(value) {
        return "'" + String(value).replace(/'/g, "'\\''") + "'"
    }

    function refresh() {
        listProc.running = false
        listProc.running = true
        currentProc.running = false
        currentProc.running = true
    }

    function apply(path) {
        root.pendingPath = path
        applyProc.command = [
            "sh", "-c",
            "\"$HOME/.local/bin/wallpaper.sh\" set " + shellQuote(path)
        ]
        applyProc.running = false
        applyProc.running = true
    }

    function applyRandom() {
        root.pendingPath = ""
        applyProc.command = ["sh", "-c", "\"$HOME/.local/bin/wallpaper.sh\" random"]
        applyProc.running = false
        applyProc.running = true
    }

    Process {
        id: listProc
        command: [
            "sh", "-c",
            "find \"$HOME/Pictures/Wallpapers\" -type f " +
            "\\( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' " +
            "-o -iname '*.webp' -o -iname '*.bmp' \\) -print | sort"
        ]
        stdout: StdioCollector {
            onStreamFinished: {
                root.wallpapers = this.text.trim().split("\n").filter(Boolean)
            }
        }
    }

    Process {
        id: currentProc
        command: ["sh", "-c", "readlink -f \"$HOME/.cache/current_wallpaper\" 2>/dev/null || true"]
        stdout: StdioCollector {
            onStreamFinished: root.currentPath = this.text.trim()
        }
    }

    Process {
        id: applyProc
        stdout: StdioCollector {
            onStreamFinished: {
                root.applied(root.pendingPath || root.currentPath)
                currentProc.running = false
                currentProc.running = true
            }
        }
    }

    Component.onCompleted: refresh()

    onOpenChanged: {
        if (open) {
            searchInput.text = ""
            refresh()
            searchInput.forceActiveFocus()
        }
    }

    // Dim the desktop and close on outside click.
    Rectangle {
        anchors.fill: parent
        color: Qt.rgba(0.02, 0.02, 0.03, 0.72)

        MouseArea {
            anchors.fill: parent
            onClicked: root.dismiss()
        }
    }

    Rectangle {
        id: card
        anchors.centerIn: parent
        width: Math.min(root.width - 60, 1080)
        height: Math.min(root.height - 80, 700)
        radius: 24
        color: root.theme ? root.theme.cardBg : "#111318"
        border.width: 1
        border.color: Qt.rgba(1, 1, 1, 0.08)

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 24
            spacing: 16

            RowLayout {
                Layout.fillWidth: true
                spacing: 14

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 2

                    Text {
                        text: "Wallpaper"
                        color: root.theme ? root.theme.textColor : "#e1e2e8"
                        font.family: "Iosevka Nerd Font"
                        font.pixelSize: 22
                        font.bold: true
                    }

                    Text {
                        text: root.filtered.length + " of " + root.wallpapers.length + " wallpapers"
                        color: root.theme ? root.theme.textSecondary : "#c3c6cf"
                        font.family: "Iosevka Nerd Font"
                        font.pixelSize: 12
                    }
                }

                Rectangle {
                    Layout.preferredWidth: 320
                    Layout.fillWidth: true
                    height: 36
                    radius: 12
                    color: Qt.rgba(1, 1, 1, 0.05)
                    border.width: 1
                    border.color: Qt.rgba(1, 1, 1, 0.07)

                    Text {
                        anchors.fill: parent
                        anchors.leftMargin: 12
                        anchors.rightMargin: 12
                        verticalAlignment: Text.AlignVCenter
                        text: "Search wallpapers…"
                        color: Qt.rgba(1, 1, 1, 0.35)
                        font.family: "Iosevka Nerd Font"
                        font.pixelSize: 13
                        visible: searchInput.text === ""
                    }

                    TextInput {
                        id: searchInput
                        anchors.fill: parent
                        anchors.leftMargin: 12
                        anchors.rightMargin: 12
                        verticalAlignment: TextInput.AlignVCenter
                        color: root.theme ? root.theme.textColor : "#e1e2e8"
                        font.family: "Iosevka Nerd Font"
                        font.pixelSize: 13
                        selectByMouse: true
                        onTextChanged: root.searchText = text

                        Keys.onPressed: {
                            if (event.key === Qt.Key_Escape) {
                                root.dismiss()
                                event.accepted = true
                            }
                        }
                    }
                }

                Rectangle {
                    Layout.preferredWidth: 34
                    Layout.preferredHeight: 34
                    radius: 17
                    color: Qt.rgba(1, 1, 1, 0.06)

                    Text {
                        anchors.centerIn: parent
                        text: "×"
                        color: root.theme ? root.theme.textColor : "#e1e2e8"
                        font.pixelSize: 18
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: root.dismiss()
                    }
                }
            }

            GridView {
                id: grid
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                cellWidth: 188
                cellHeight: 162
                model: root.filtered

                delegate: Thumb {
                    width: grid.cellWidth
                    height: grid.cellHeight
                    path: modelData
                    current: modelData === root.currentPath
                    theme: root.theme
                    onClicked: root.apply(modelData)
                }
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: 12

                Text {
                    text: root.currentPath ? "Current: " + root.currentPath.split("/").pop() : "No wallpaper applied yet"
                    color: root.theme ? root.theme.textSecondary : "#c3c6cf"
                    font.family: "Iosevka Nerd Font"
                    font.pixelSize: 12
                    elide: Text.ElideRight
                    Layout.fillWidth: true
                }

                Rectangle {
                    Layout.preferredWidth: 120
                    Layout.preferredHeight: 34
                    radius: 17
                    color: Qt.rgba((root.theme ? root.theme.primary.r : 0.64),
                                   (root.theme ? root.theme.primary.g : 0.79),
                                   (root.theme ? root.theme.primary.b : 1.0), 0.20)
                    border.width: 1
                    border.color: root.theme ? root.theme.primary : "#a3c9fe"

                    Text {
                        anchors.centerIn: parent
                        text: "⤨ Random"
                        color: root.theme ? root.theme.primary : "#a3c9fe"
                        font.family: "Iosevka Nerd Font"
                        font.pixelSize: 13
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: root.applyRandom()
                    }
                }
            }
        }

        Text {
            visible: root.filtered.length === 0
            anchors.centerIn: parent
            text: "No wallpapers found"
            color: root.theme ? root.theme.textSecondary : "#c3c6cf"
            font.pixelSize: 16
        }
    }
}
