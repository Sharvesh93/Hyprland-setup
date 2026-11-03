pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property int brightness: 50

    function refresh() {
        if (!getBriProc.running) {
            getBriProc.running = true;
        }
    }

    function setBrightness(pct) {
        pct = Math.max(5, Math.min(100, Math.round(pct)));
        root.brightness = pct;
        setBriProc.command = ["brightnessctl", "set", pct + "%"];
        setBriProc.running = true;
    }

    Process {
        id: setBriProc
        running: false
    }

    Process {
        id: getBriProc
        command: ["brightnessctl", "-m"]
        running: true
        stdout: SplitParser {
            onRead: line => {
                var str = line.trim();
                // Format: device,class,curr,curr_pct,max
                var parts = str.split(",");
                if (parts.length >= 4) {
                    var pctStr = parts[3].replace("%", "").trim();
                    var val = parseInt(pctStr, 10);
                    if (!isNaN(val)) {
                        root.brightness = val;
                    }
                }
            }
        }
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: root.refresh()
    }
}
