pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property int volume: 50
    property bool muted: false

    function refresh() {
        if (!getVolProc.running) {
            getVolProc.running = true;
        }
    }

    function setVolume(pct) {
        pct = Math.max(0, Math.min(100, Math.round(pct)));
        root.volume = pct;
        setVolProc.command = ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", (pct / 100).toFixed(2)];
        setVolProc.running = true;
    }

    function toggleMute() {
        root.muted = !root.muted;
        setMuteProc.command = ["wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle"];
        setMuteProc.running = true;
        refreshTimer.restart();
    }

    Process {
        id: setVolProc
        running: false
    }

    Process {
        id: setMuteProc
        running: false
    }

    Process {
        id: getVolProc
        command: ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"]
        running: true
        stdout: SplitParser {
            onRead: line => {
                var str = line.trim();
                // Format: "Volume: 0.90" or "Volume: 0.90 [MUTED]"
                if (str.startsWith("Volume:")) {
                    var isMuted = str.indexOf("[MUTED]") !== -1;
                    root.muted = isMuted;
                    var match = str.match(/Volume:\s+([0-9.]+)/);
                    if (match && match[1]) {
                        var v = parseFloat(match[1]);
                        root.volume = Math.round(v * 100);
                    }
                }
            }
        }
    }

    Timer {
        id: refreshTimer
        interval: 1500
        running: true
        repeat: true
        onTriggered: root.refresh()
    }
}
