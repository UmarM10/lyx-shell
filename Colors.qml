pragma Singleton

import QtQuick
import Quickshell

Singleton {
    id: colors

    // Primary Colors
    property color primary: "#ffb4a2"
    property color primaryLight: "#8f4b3a"
    property color primaryDark: "#ffb4a2"
    property color topPrimary: "#561f11"
    property color primaryContainer: "#723425"
    property color primaryContainerLight: "#ffdad2"
    property color primaryContainerDark: "#723425"
    property color primaryContainerVariant: "#321710"
    property color topPrimaryContainer: "#ffdad2"

    // Secondary Colors
    property color secondary: "#e7bdb3"
    property color topSecondary: "#442a23"
    property color secondaryContainer: "#5d4038"
    property color topSecondaryContainer: "#ffdad2"

    // Tertiary Colors
    property color tertiary: "#dac58c"
    property color topTertiary: "#3c2f04"
    property color tertiaryContainer: "#544519"
    property color topTertiaryContainer: "#f7e1a6"

    // Backgrounds & Surfaces
    property color background: "#1a110f"
    property color topBackground: "#f1dfda"
    property color surface: "#1a110f"
    property color topSurface: "#f1dfda"
    property color surfaceVariant: "#534340"
    property color topSurfaceVariant: "#d8c2bd"
    
    // Outlines
    property color outline: "#a08c88"
    property color outlineVariant: "#534340"
}