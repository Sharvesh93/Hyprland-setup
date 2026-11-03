pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property int activeWorkspace: 1
    property var occupiedWorkspaces: [1]

    function isOccupied(wsId) {
        return occupiedWorkspaces.indexOf(wsId) !== -1;
    }

    function switchWorkspace(wsId) {
        dispatchProc.command = ["hyprctl", "dispatch", "hl.dsp.focus({ workspace = " + wsId.toString() + " })"];
        dispatchProc.running = true;
    }

    Process {
        id: dispatchProc
        running: false
    }

    Process {
        id: watcher
        command: ["python3", "-u", Quickshell.env("HOME") + "/.config/quickshell/services/hyprland-watcher.py"]
        running: true
        stdout: SplitParser {
            onRead: line => {
                var str = line.trim();
                if (str.startsWith("STATUS:")) {
                    var parts = str.split(":");
                    if (parts.length >= 2) {
                        var act = parseInt(parts[1], 10);
                        if (!isNaN(act)) root.activeWorkspace = act;
                    }
                    if (parts.length >= 3 && parts[2].length > 0) {
                        var occ = parts[2].split(",").map(x => parseInt(x, 10)).filter(x => !isNaN(x));
                        root.occupiedWorkspaces = occ;
                    }
                }
            }
        }
    }
}
