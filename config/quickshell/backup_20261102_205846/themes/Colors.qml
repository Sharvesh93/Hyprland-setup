pragma Singleton
import QtQuick

QtObject {
    id: colors

    // Dominant and complementary colors dynamically generated from wallpaper
    readonly property color background: "#111418"
    readonly property color surface: "#111418"
    readonly property color surfaceContainer: "#1d2024"
    readonly property color surfaceContainerLow: "#191c20"
    readonly property color surfaceContainerHigh: "#272a2f"
    readonly property color surfaceContainerHighest: "#32353a"

    readonly property color primary: "#a2c9fe"
    readonly property color primaryContainer: "#1d4875"
    readonly property color textOnPrimary: "#00325a"
    readonly property color textOnPrimaryContainer: "#d2e4ff"

    readonly property color secondary: "#bbc7db"
    readonly property color secondaryContainer: "#3c4858"
    readonly property color textOnSecondary: "#263141"

    readonly property color tertiary: "#d8bde4"
    readonly property color tertiaryContainer: "#533f5f"
    readonly property color textOnTertiary: "#3c2947"

    readonly property color textColor: "#e1e2e8"
    readonly property color textSecondary: "#c3c6cf"
    readonly property color textTertiary: "#8d9199"

    readonly property color outline: "#8d9199"
    readonly property color outlineVariant: "#43474e"

    readonly property color error: "#ffb4ab"
    readonly property color errorContainer: "#93000a"

    // Glass & transparency tuning for minimalist rice
    readonly property color barBg: Qt.rgba(surface.r, surface.g, surface.b, 0.68)
    readonly property color cardBg: Qt.rgba(surfaceContainer.r, surfaceContainer.g, surfaceContainer.b, 0.75)
    readonly property color cardBgHover: Qt.rgba(surfaceContainerHigh.r, surfaceContainerHigh.g, surfaceContainerHigh.b, 0.85)
    readonly property color activePillBg: Qt.rgba(primary.r, primary.g, primary.b, 0.22)
    readonly property color activePillFg: primary
    readonly property color inactivePillBg: Qt.rgba(surfaceContainerHighest.r, surfaceContainerHighest.g, surfaceContainerHighest.b, 0.35)
    readonly property color modalBackdrop: Qt.rgba(0.02, 0.02, 0.03, 0.55)
}
