import QtQuick
import Quickshell
import Quickshell.Io

// Runs a shell command on an interval and exposes its trimmed stdout as
// `value`. Setting `running` to false pauses polling.
Scope {
    id: root

    property string command: ""
    property int interval: 3000
    property bool running: true
    property string value: ""

    Process {
        id: proc
        command: ["sh", "-c", root.command]
        stdout: StdioCollector {
            onStreamFinished: root.value = this.text.trim()
        }
    }

    Timer {
        interval: root.interval
        running: root.running
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            // Process.running = true does not restart an already-running
            // process, so stop it before starting the next poll.
            proc.running = false
            proc.running = true
        }
    }

    onRunningChanged: {
        if (!running) proc.running = false
    }
}
