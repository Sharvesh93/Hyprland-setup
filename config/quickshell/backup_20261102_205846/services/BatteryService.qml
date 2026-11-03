pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property bool hasBattery: true
    property int percentage: 100
    property string status: "Full"
    property bool isCharging: status === "Charging"

    Process {
        id: batProc
        command: ["sh", "-c", "cat /sys/class/power_supply/BAT*/capacity /sys/class/power_supply/BAT*/status 2>/dev/null"]
        running: true
        stdout: SplitParser {
            property int lineIdx: 0
            onRead: line => {
                var str = line.trim();
                if (lineIdx === 0) {
                    var pct = parseInt(str, 10);
                    if (!isNaN(pct)) root.percentage = pct;
                    lineIdx = 1;
                } else {
                    root.status = str;
                    lineIdx = 0;
                }
            }
        }
    }

    Timer {
        interval: 10000
        running: true
        repeat: true
        onTriggered: {
            if (!batProc.running) batProc.running = true;
        }
    }
}
