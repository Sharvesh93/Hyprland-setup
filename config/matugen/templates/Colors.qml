pragma Singleton
import QtQuick

QtObject {
    id: colors

    // Dominant and complementary colors dynamically generated from wallpaper
    readonly property color background: "{{colors.background.default.hex}}"
    readonly property color surface: "{{colors.surface.default.hex}}"
    readonly property color surfaceContainer: "{{colors.surface_container.default.hex}}"
    readonly property color surfaceContainerLow: "{{colors.surface_container_low.default.hex}}"
    readonly property color surfaceContainerHigh: "{{colors.surface_container_high.default.hex}}"
    readonly property color surfaceContainerHighest: "{{colors.surface_container_highest.default.hex}}"

    readonly property color primary: "{{colors.primary.default.hex}}"
    readonly property color primaryContainer: "{{colors.primary_container.default.hex}}"
    readonly property color textOnPrimary: "{{colors.on_primary.default.hex}}"
    readonly property color textOnPrimaryContainer: "{{colors.on_primary_container.default.hex}}"

    readonly property color secondary: "{{colors.secondary.default.hex}}"
    readonly property color secondaryContainer: "{{colors.secondary_container.default.hex}}"
    readonly property color textOnSecondary: "{{colors.on_secondary.default.hex}}"

    readonly property color tertiary: "{{colors.tertiary.default.hex}}"
    readonly property color tertiaryContainer: "{{colors.tertiary_container.default.hex}}"
    readonly property color textOnTertiary: "{{colors.on_tertiary.default.hex}}"

    readonly property color textColor: "{{colors.on_surface.default.hex}}"
    readonly property color textSecondary: "{{colors.on_surface_variant.default.hex}}"
    readonly property color textTertiary: "{{colors.outline.default.hex}}"

    readonly property color outline: "{{colors.outline.default.hex}}"
    readonly property color outlineVariant: "{{colors.outline_variant.default.hex}}"

    readonly property color error: "{{colors.error.default.hex}}"
    readonly property color errorContainer: "{{colors.error_container.default.hex}}"

    // Glass & transparency tuning for minimalist rice
    readonly property color barBg: Qt.rgba(surface.r, surface.g, surface.b, 0.68)
    readonly property color cardBg: Qt.rgba(surfaceContainer.r, surfaceContainer.g, surfaceContainer.b, 0.75)
    readonly property color cardBgHover: Qt.rgba(surfaceContainerHigh.r, surfaceContainerHigh.g, surfaceContainerHigh.b, 0.85)
    readonly property color activePillBg: Qt.rgba(primary.r, primary.g, primary.b, 0.22)
    readonly property color activePillFg: primary
    readonly property color inactivePillBg: Qt.rgba(surfaceContainerHighest.r, surfaceContainerHighest.g, surfaceContainerHighest.b, 0.35)
    readonly property color modalBackdrop: Qt.rgba(0.02, 0.02, 0.03, 0.55)
}
