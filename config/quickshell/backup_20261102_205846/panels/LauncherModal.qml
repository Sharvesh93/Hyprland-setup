import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import Quickshell.Io
import "../themes"

PanelWindow {
    id: root

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    color: Colors.modalBackdrop
    visible: false

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "quickshell-launcher"
    WlrLayershell.keyboardFocus: root.visible ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None

    property var allApps: []
    property var filteredApps: []
    property int selectedIndex: 0

    function toggle() {
        if (root.visible) {
            close();
        } else {
            open();
        }
    }

    function open() {
        root.visible = true;
        searchField.text = "";
        root.selectedIndex = 0;
        updateFilter();
        searchField.forceActiveFocus();
    }

    function close() {
        root.visible = false;
    }

    function updateFilter() {
        var query = searchField.text.trim().toLowerCase();
        if (query === "") {
            root.filteredApps = root.allApps;
        } else {
            root.filteredApps = root.allApps.filter(function(a) {
                return a.name.toLowerCase().indexOf(query) !== -1 || a.exec.toLowerCase().indexOf(query) !== -1;
            });
        }
        root.selectedIndex = 0;
    }

    function launchSelected() {
        if (root.filteredApps.length > 0 && root.selectedIndex < root.filteredApps.length) {
            var app = root.filteredApps[root.selectedIndex];
            launchApp(app.exec);
        }
    }

    function launchApp(execCmd) {
        launchProc.command = ["sh", "-c", execCmd + " &"];
        launchProc.running = true;
        root.close();
    }

    Process {
        id: launchProc
        running: false
    }

    Process {
        id: appLoader
        command: ["cat", Quickshell.env("HOME") + "/.config/quickshell/modules/apps.json"]
        running: true
        stdout: SplitParser {
            onRead: line => {
                try {
                    root.allApps = JSON.parse(line.trim());
                    root.updateFilter();
                } catch(e) {
                    console.log("App parse error:", e);
                }
            }
        }
    }

    Component.onCompleted: {
        appLoader.running = true;
    }

    // Backdrop click dismisses
    MouseArea {
        anchors.fill: parent
        onClicked: root.close()
    }

    // Centered launcher container
    Rectangle {
        id: card
        width: 540
        height: 480
        anchors.centerIn: parent
        radius: Theme.radiusLarge
        color: Colors.cardBg

        // Prevent click through to backdrop
        MouseArea {
            anchors.fill: parent
            onClicked: {}
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 16
            spacing: 12

            // Search input field
            Rectangle {
                Layout.fillWidth: true
                height: 44
                radius: Theme.radiusNormal
                color: Colors.cardBgHover

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 14
                    anchors.rightMargin: 14
                    spacing: 10

                    Text {
                        text: "󰍉"
                        font.family: Theme.fontFamily
                        font.pixelSize: Theme.fontSizeLarge
                        color: Colors.primary
                    }

                    TextInput {
                        id: searchField
                        Layout.fillWidth: true
                        font.family: Theme.fontFamily
                        font.pixelSize: Theme.fontSizeNormal
                        color: Colors.textColor
                        selectionColor: Colors.primary
                        selectedTextColor: Colors.textOnPrimary
                        clip: true

                        Text {
                            text: "Type to search applications..."
                            font.family: Theme.fontFamily
                            font.pixelSize: Theme.fontSizeNormal
                            color: Colors.textTertiary
                            visible: !searchField.text && !searchField.activeFocus
                        }

                        onTextChanged: root.updateFilter()

                        Keys.onEscapePressed: root.close()
                        Keys.onReturnPressed: root.launchSelected()
                        Keys.onDownPressed: {
                            if (root.selectedIndex < root.filteredApps.length - 1) {
                                root.selectedIndex++;
                                appListView.positionViewAtIndex(root.selectedIndex, ListView.Contain);
                            }
                        }
                        Keys.onUpPressed: {
                            if (root.selectedIndex > 0) {
                                root.selectedIndex--;
                                appListView.positionViewAtIndex(root.selectedIndex, ListView.Contain);
                            }
                        }
                    }
                }
            }

            // Results list
            ListView {
                id: appListView
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                model: root.filteredApps
                boundsBehavior: Flickable.StopAtBounds

                delegate: Rectangle {
                    id: appItem
                    required property var modelData
                    required property int index

                    readonly property bool isSelected: root.selectedIndex === appItem.index

                    width: appListView.width
                    height: 48
                    radius: Theme.radiusSmall
                    color: isSelected ? Colors.activePillBg : (itemMouse.containsMouse ? Colors.inactivePillBg : "transparent")

                    Behavior on color {
                        ColorAnimation { duration: Theme.animDurationFast }
                    }

                    RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 12
                        anchors.rightMargin: 12
                        spacing: 12

                        IconImage {
                            Layout.preferredWidth: 28
                            Layout.preferredHeight: 28
                            source: Quickshell.iconPath(appItem.modelData.icon || "application-x-executable", 32)
                        }

                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 2

                            Text {
                                Layout.fillWidth: true
                                text: appItem.modelData.name
                                font.family: Theme.fontFamily
                                font.pixelSize: Theme.fontSizeNormal
                                font.bold: appItem.isSelected
                                color: appItem.isSelected ? Colors.primary : Colors.textColor
                                elide: Text.ElideRight
                            }

                            Text {
                                Layout.fillWidth: true
                                text: appItem.modelData.exec
                                font.family: Theme.fontFamily
                                font.pixelSize: 10
                                color: Colors.textTertiary
                                elide: Text.ElideRight
                            }
                        }
                    }

                    MouseArea {
                        id: itemMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onEntered: root.selectedIndex = appItem.index
                        onClicked: root.launchApp(appItem.modelData.exec)
                    }
                }
            }
        }
    }
}
