pragma Singleton

import QtQuick
import Quickshell

Singleton {
    id: colors

    // Primary Colors
    property color primary: "#8fcff3"
    property color primaryLight: "#1b6585"
    property color primaryDark: "#8fcff3"
    property color topPrimary: "#003549"
    property color primaryContainer: "#004c68"
    property color primaryContainerLight: "#c3e8ff"
    property color primaryContainerDark: "#004c68"
    property color primaryContainerVariant: "#003042"
    property color topPrimaryContainer: "#c3e8ff"

    // Secondary Colors
    property color secondary: "#b5c9d7"
    property color topSecondary: "#20333d"
    property color secondaryContainer: "#364954"
    property color topSecondaryContainer: "#d1e5f3"

    // Tertiary Colors
    property color tertiary: "#c9c1ea"
    property color topTertiary: "#312c4c"
    property color tertiaryContainer: "#484264"
    property color topTertiaryContainer: "#e6deff"

    // Backgrounds & Surfaces
    property color background: "#0f1417"
    property color topBackground: "#dfe3e7"
    property color surface: "#0f1417"
    property color topSurface: "#dfe3e7"
    property color surfaceVariant: "#41484d"
    property color topSurfaceVariant: "#c0c7cd"
    
    // Outlines
    property color outline: "#8a9297"
    property color outlineVariant: "#41484d"
}