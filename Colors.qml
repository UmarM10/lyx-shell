pragma Singleton

import QtQuick
import Quickshell

Singleton {
    id: colors

    // Primary Colors
    property color primary: "#a4c9fe"
    property color primaryLight: "#3b608f"
    property color primaryDark: "#a4c9fe"
    property color topPrimary: "#00315d"
    property color primaryContainer: "#204876"
    property color primaryContainerLight: "#d4e3ff"
    property color primaryContainerDark: "#204876"
    property color primaryContainerVariant: "#0e2034"
    property color topPrimaryContainer: "#d4e3ff"

    // Secondary Colors
    property color secondary: "#bcc7db"
    property color topSecondary: "#263141"
    property color secondaryContainer: "#3d4758"
    property color topSecondaryContainer: "#d8e3f8"

    // Tertiary Colors
    property color tertiary: "#d9bde3"
    property color topTertiary: "#3d2946"
    property color tertiaryContainer: "#543f5e"
    property color topTertiaryContainer: "#f6d9ff"

    // Backgrounds & Surfaces
    property color background: "#111318"
    property color topBackground: "#e1e2e9"
    property color surface: "#111318"
    property color topSurface: "#e1e2e9"
    property color surfaceVariant: "#43474e"
    property color topSurfaceVariant: "#c3c6cf"
    
    // Outlines
    property color outline: "#8d9199"
    property color outlineVariant: "#43474e"
}