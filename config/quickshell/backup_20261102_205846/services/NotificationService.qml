pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.Notifications

Singleton {
    id: root

    property var currentNotification: null
    property bool visibleToast: false

    function dismiss() {
        visibleToast = false;
        currentNotification = null;
    }

    Connections {
        target: NotificationServer
        function onNotification(notif) {
            root.currentNotification = {
                id: notif.id,
                appName: notif.appName || "Notification",
                summary: notif.summary || "",
                body: notif.body || "",
                urgency: notif.urgency
            };
            root.visibleToast = true;
            toastTimer.restart();
        }
    }

    Timer {
        id: toastTimer
        interval: 4500
        running: false
        repeat: false
        onTriggered: root.dismiss()
    }
}
