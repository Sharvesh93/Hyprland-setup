pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property bool connected: true
    property string ssid: "Connected"
    property int signal: 100

    Process {
        id: netProc
        command: ["sh", "-c", "nmcli -t -f active,ssid,signal dev wifi 2>/dev/null | grep '^yes:' || echo 'no::0'"]
        running: true
        stdout: SplitParser {
            onRead: line => {
                var str = line.trim();
                var parts = str.split(":");
                if (parts.length >= 3) {
                    root.connected = (parts[0] === "yes");
                    root.ssid = parts[1] || (root.connected ? "Connected" : "Disconnected");
                    var sig = parseInt(parts[2], 10);
                    root.signal = isNaN(sig) ? 80 : sig;
                }
            }
        }
    }

    Timer {
        interval: 6000
        running: true
        repeat: true
        onTriggered: {
            if (!netProc.running) netProc.running = true;
        }
    }
}
