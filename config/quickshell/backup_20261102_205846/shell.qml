import QtQuick
import Quickshell
import Quickshell.Io
import "themes"
import "panels"
import "services"

ShellRoot {
    id: root

    // Instantiate TopBar on all active monitors
    Variants {
        model: Quickshell.screens

        TopBar {
            required property var modelData
            screen: modelData

            onToggleLauncher: launcherModal.toggle()
            onToggleControlCenter: ccModal.toggle()
        }
    }

    // Centered Minimal Application Launcher
    LauncherModal {
        id: launcherModal
    }

    // Quick Settings & Controls Modal
    ControlCenterModal {
        id: ccModal
    }

    // Minimal Notification Toast
    NotificationToast {
        id: notifToast
    }

    // IPC Handlers for external keybindings and scripts
    IpcHandler {
        target: "launcher"

        function toggle() {
            launcherModal.toggle();
        }

        function open() {
            launcherModal.open();
        }

        function close() {
            launcherModal.close();
        }
    }

    IpcHandler {
        target: "control-center"

        function toggle() {
            ccModal.toggle();
        }

        function close() {
            ccModal.close();
        }
    }

    IpcHandler {
        target: "theme"

        function reload() {
            console.log("Quickshell: Reloading dynamic theme palette...");
            // Colors update automatically via QML bindings
        }
    }
}
