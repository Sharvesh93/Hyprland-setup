pragma Singleton
import QtQuick

QtObject {
    id: theme

    // Typography: Using Maple Mono NF CN
    readonly property string fontFamily: "Maple Mono NF CN"
    readonly property string fontFallback: "monospace"

    // Font Weights
    readonly property int fontWeightRegular: Font.Normal
    readonly property int fontWeightMedium: Font.Medium
    readonly property int fontWeightSemiBold: Font.DemiBold
    readonly property int fontWeightBold: Font.Bold

    readonly property int fontSizeSmall: 10
    readonly property int fontSizeNormal: 11
    readonly property int fontSizeMedium: 12
    readonly property int fontSizeLarge: 13
    readonly property int fontSizeTitle: 16

    // Radii: Subtle rounding only where appropriate
    readonly property int radiusSmall: 4
    readonly property int radiusNormal: 6
    readonly property int radiusLarge: 8
    readonly property int radiusPill: 14

    // Spacing & Padding: Compact spacing, clean alignment
    readonly property int spacingSmall: 3
    readonly property int spacingNormal: 6
    readonly property int spacingLarge: 10

    readonly property int paddingSmall: 3
    readonly property int paddingNormal: 6
    readonly property int paddingLarge: 10

    // Layout metrics (Targeting ~28-30px total bar height)
    readonly property int barHeight: 26
    readonly property int barMarginTop: 2
    readonly property int barMarginSide: 8

    // Animations: Subtle, smooth transitions
    readonly property int animDurationFast: 150
    readonly property int animDurationNormal: 220
    readonly property int animDurationSlow: 320
    readonly property var animEasing: Easing.OutCubic
}
