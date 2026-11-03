pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.Notifications

Singleton {
    id: root

    property var currentNotification: null
    property bool visibleToast: false

    // Function to dismiss the current notification and cleanly stop timers
    function dismiss() {
        toastTimer.stop();
        root.visibleToast = false;
        root.currentNotification = null;
    }

    // Displays a notification, automatically cancelling any existing timer to prevent stacking
    function showNotification(appName, summary, body, timeoutMs, isReload) {
        toastTimer.stop();

        root.currentNotification = {
            id: Date.now(),
            appName: appName || "Notification",
            summary: summary || "",
            body: body || "",
            isReload: !!isReload
        };

        root.visibleToast = true;

        // Auto-dismiss: default approximately 3 seconds for reload notifications
        toastTimer.interval = timeoutMs > 0 ? timeoutMs : 3000;
        toastTimer.restart();
    }

    // Specialized notification for config reloads
    function notifyReload() {
        console.log("NotificationService: displaying config reloaded notification");
        root.showNotification("Quickshell", "Config reloaded", "Changes applied successfully.", 3000, true);
    }

    // Check if this instance was loaded via config reload
    function checkReload() {
        var startTime = Number(Quickshell.launchTime);
        var diff = Date.now() - startTime;
        console.log("NotificationService checkReload diff:", diff);
        if (diff > 500) {
            root.notifyReload();
        }
    }

    // Connect to external desktop notifications via NotificationServer
    Connections {
        target: NotificationServer

        function onNotification(notif) {
            var timeout = (notif.expireTimeout && notif.expireTimeout > 0) ? notif.expireTimeout : 4000;
            root.showNotification(
                notif.appName || "Notification",
                notif.summary || "",
                notif.body || "",
                timeout,
                false
            );
        }
    }

    // Dedicated timer for clean auto-dismissal
    Timer {
        id: toastTimer
        interval: 3000
        running: false
        repeat: false
        onTriggered: {
            console.log("NotificationService: auto-dismiss timer triggered");
            root.visibleToast = false;
            root.currentNotification = null;
        }
    }
}
