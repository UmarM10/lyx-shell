pragma Singleton

import QtQuick
import Quickshell

Singleton {
    id: colors

    // Primary Colors
    property color primary: "#8fd5af"
    property color primaryLight: "#246a4b"
    property color primaryDark: "#8fd5af"
    property color topPrimary: "#003823"
    property color primaryContainer: "#005235"
    property color primaryContainerLight: "#aaf2ca"
    property color primaryContainerDark: "#005235"
    property color primaryContainerVariant: "#00422b"
    property color topPrimaryContainer: "#aaf2ca"

    // Secondary Colors
    property color secondary: "#b4ccbc"
    property color topSecondary: "#203529"
    property color secondaryContainer: "#364b3f"
    property color topSecondaryContainer: "#d0e8d8"

    // Tertiary Colors
    property color tertiary: "#a4cddd"
    property color topTertiary: "#063542"
    property color tertiaryContainer: "#234c5a"
    property color topTertiaryContainer: "#c0e9fa"

    // Backgrounds & Surfaces
    property color background: "#0f1511"
    property color topBackground: "#dee4de"
    property color surface: "#0f1511"
    property color topSurface: "#dee4de"
    property color surfaceVariant: "#404943"
    property color topSurfaceVariant: "#c0c9c1"
    
    // Outlines
    property color outline: "#8a938c"
    property color outlineVariant: "#404943"
}