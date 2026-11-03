pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property int cpuPercent: 0
    property int ramPercent: 0

    Process {
        id: sysmonProc
        command: ["sh", "-c", "awk '/MemTotal/ {t=$2} /MemAvailable/ {a=$2} END {printf \"RAM:%d\\n\", int((1-a/t)*100)}' /proc/meminfo"]
        running: true
        stdout: SplitParser {
            onRead: line => {
                var str = line.trim();
                if (str.startsWith("RAM:")) {
                    var val = parseInt(str.substring(4), 10);
                    if (!isNaN(val)) root.ramPercent = val;
                }
            }
        }
    }

    Timer {
        interval: 3000
        running: true
        repeat: true
        onTriggered: {
            if (!sysmonProc.running) sysmonProc.running = true;
        }
    }
}
