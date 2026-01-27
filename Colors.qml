pragma Singleton

import QtQuick
import Quickshell

Singleton {
    id: colors

    // Primary Colors
    property color primary: "#9ecafc"
    property color primaryLight: "#33618d"
    property color primaryDark: "#9ecafc"
    property color topPrimary: "#003256"
    property color primaryContainer: "#154974"
    property color primaryContainerLight: "#d0e4ff"
    property color primaryContainerDark: "#154974"
    property color primaryContainerVariant: "#0a2338"
    property color topPrimaryContainer: "#d0e4ff"

    // Secondary Colors
    property color secondary: "#bac8db"
    property color topSecondary: "#243140"
    property color secondaryContainer: "#3b4857"
    property color topSecondaryContainer: "#d6e4f7"

    // Tertiary Colors
    property color tertiary: "#d5bee5"
    property color topTertiary: "#3a2a48"
    property color tertiaryContainer: "#514060"
    property color topTertiaryContainer: "#f1dbff"

    // Backgrounds & Surfaces
    property color background: "#101418"
    property color topBackground: "#e0e2e8"
    property color surface: "#101418"
    property color topSurface: "#e0e2e8"
    property color surfaceVariant: "#42474e"
    property color topSurfaceVariant: "#c2c7cf"
    
    // Outlines
    property color outline: "#8c9199"
    property color outlineVariant: "#42474e"
}
