pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import qs.services

Singleton {
    id: colors

	property string colorSchemeMode: "wallpaper" // Wallpaper, dark, or light
	readonly property string colorScheme: {
		if (colorSchemeMode === "wallpaper") {
			return Wallpaper.colorScheme
		} else return colorSchemeMode
	}
	property string colorType: "scheme-tonal-spot"

	function updateColors() {}
	Process {
		id: colorUpdater
		running: true
		command: [
			"matugen", "image", Wallpaper.currentPath,
			"--mode", colors.colorScheme, 
			"--type", colors.colorType, 
			"--source-color-index", 0
		]
	}


    // Primary Colors
    property color primary: "#bcc3ff"
    // property color primaryLight: "#525a92"
    // property color primaryDark: "#bcc3ff"
    property color topPrimary: "#242c61"
    property color primaryContainer: "#3b4279"
	property color primaryContainerBrightness20: "#555eac"
    // property color primaryContainerLight: "#dfe0ff"
    // property color primaryContainerDark: "#3b4279"
    property color primaryContainerVariant: { 
		Wallpaper.colorScheme === "dark" ?
		Qt.darker(primaryContainer, 2.0) : 
		primaryContainerBrightness20
	}
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
    
    // Outlines & Errors
    property color outline: "#90909a"
    property color outlineVariant: "#46464f"
	property color error: "#ffb4ab"

	IpcHandler {
		enabled: true 
		target: "colors"

		function applyTheme(themeJsonString: string) {
            // Parse the JSON string sent from your shell script
            let theme = JSON.parse(themeJsonString);

            // Primary Colors
            if (theme.primary) colors.primary = theme.primary;
            if (theme.primaryContainer) colors.primaryContainer = theme.primaryContainer;
            if (theme.topPrimary) colors.topPrimary = theme.topPrimary;
            if (theme.topPrimaryContainer) colors.topPrimaryContainer = theme.topPrimaryContainer;
            if (theme.primaryContainerBrightness20) colors.primaryContainerBrightness20 = theme.primaryContainerBrightness20;

            // Secondary Colors
            if (theme.secondary) colors.secondary = theme.secondary;
            if (theme.secondaryContainer) colors.secondaryContainer = theme.secondaryContainer;
            if (theme.topSecondary) colors.topSecondary = theme.topSecondary;
            if (theme.topSecondaryContainer) colors.topSecondaryContainer = theme.topSecondaryContainer;

            // Tertiary Colors 
            if (theme.tertiary) colors.tertiary = theme.tertiary;
            if (theme.tertiaryContainer) colors.tertiaryContainer = theme.tertiaryContainer;
            if (theme.topTertiary) colors.topTertiary = theme.topTertiary;
            if (theme.topTertiaryContainer) colors.topTertiaryContainer = theme.topTertiaryContainer;

            // Backgrounds & Surfaces 
            if (theme.background) colors.background = theme.background;
            if (theme.topBackground) colors.topBackground = theme.topBackground;
            if (theme.surface) colors.surface = theme.surface;
            if (theme.topSurface) colors.topSurface = theme.topSurface;
            if (theme.surfaceVariant) colors.surfaceVariant = theme.surfaceVariant;
            if (theme.topSurfaceVariant) colors.topSurfaceVariant = theme.topSurfaceVariant;

            // Outlines & Errors 
            if (theme.outline) colors.outline = theme.outline;
            if (theme.outlineVariant) colors.outlineVariant = theme.outlineVariant;
            if (theme.error) colors.error = theme.error;
        }
	}
}
