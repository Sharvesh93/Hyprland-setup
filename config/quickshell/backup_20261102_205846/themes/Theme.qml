pragma Singleton
import QtQuick

QtObject {
    id: theme

    // Typography: Using Maple Mono NF as required
    readonly property string fontFamily: "Maple Mono NF"
    readonly property string fontFallback: "monospace"

    readonly property int fontSizeSmall: 11
    readonly property int fontSizeNormal: 12
    readonly property int fontSizeMedium: 13
    readonly property int fontSizeLarge: 15
    readonly property int fontSizeTitle: 18

    // Radii: Subtle rounding only where appropriate (no decorative borders)
    readonly property int radiusSmall: 6
    readonly property int radiusNormal: 8
    readonly property int radiusLarge: 12
    readonly property int radiusPill: 20

    // Spacing & Padding: Minimal spacing, clean alignment
    readonly property int spacingSmall: 4
    readonly property int spacingNormal: 8
    readonly property int spacingLarge: 12

    readonly property int paddingSmall: 4
    readonly property int paddingNormal: 8
    readonly property int paddingLarge: 12

    // Layout metrics
    readonly property int barHeight: 34
    readonly property int barMarginTop: 6
    readonly property int barMarginSide: 8

    // Animations: Subtle, smooth transitions
    readonly property int animDurationFast: 150
    readonly property int animDurationNormal: 220
    readonly property int animDurationSlow: 320
    readonly property var animEasing: Easing.OutCubic
}
