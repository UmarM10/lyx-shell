pragma Singleton

import QtQuick
import Quickshell

Singleton {
    id: colors

    // Primary Colors
    property color primary: "#bcc3ff"
    property color primaryLight: "#525a92"
    property color primaryDark: "#bcc3ff"
    property color topPrimary: "#242c61"
    property color primaryContainer: "#3b4279"
    property color primaryContainerLight: "#dfe0ff"
    property color primaryContainerDark: "#3b4279"
    property color primaryContainerVariant: "#16182d"
    property color topPrimaryContainer: "#dfe0ff"

    // Secondary Colors
    property color secondary: "#c4c5dd"
    property color topSecondary: "#2d2f42"
    property color secondaryContainer: "#434559"
    property color topSecondaryContainer: "#e0e1f9"

    // Tertiary Colors
    property color tertiary: "#e6bad7"
    property color topTertiary: "#45263d"
    property color tertiaryContainer: "#5d3c54"
    property color topTertiaryContainer: "#ffd7f0"

    // Backgrounds & Surfaces
    property color background: "#131318"
    property color topBackground: "#e4e1e9"
    property color surface: "#131318"
    property color topSurface: "#e4e1e9"
    property color surfaceVariant: "#46464f"
    property color topSurfaceVariant: "#c7c5d0"
    
    // Outlines
    property color outline: "#90909a"
    property color outlineVariant: "#46464f"
}