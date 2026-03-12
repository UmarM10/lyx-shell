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
    property color primary: "#a4c9fe"
    // property color primaryLight: "#3b608f"
    // property color primaryDark: "#a4c9fe"
    property color topPrimary: "#00315d"
    property color primaryContainer: "#204876"
	property color primaryContainerBrightness20: "#306db2"
    // property color primaryContainerLight: "#d4e3ff"
    // property color primaryContainerDark: "#204876"
    property color primaryContainerVariant: { 
		Wallpaper.colorScheme === "dark" ?
		Qt.darker(primaryContainer, 2.0) : 
		primaryContainerBrightness20
	}
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
    
    // Outlines & Errors
    property color outline: "#8d9199"
    property color outlineVariant: "#43474e"
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

	// 	// Primary Colors
	// 	function primaryColor(color: color) { colors.primary = color }
	// 	function primaryContainerColor(color: color) { colors.primaryContainer = color }
	// 	function onPrimaryColor(color: color) { colors.topPrimary = color }
	// 	function onPrimaryContainerColor(color: color) { colors.topPrimaryContainer = color }
	// 	function primaryContainerBrightness20(color: color) { colors.primaryContainerBrightness20 = color }
	//
	// 	// Secondary Colors
	// 	function secondaryColor(color: color) { colors.secondary = color }
	// 	function secondaryContainerColor(color: color) { colors.secondaryContainer = color }
	// 	function onSecondaryColor(color: color) { colors.topSecondary = color }
	// 	function onSecondaryContainerColor(color: color) { colors.topSecondaryContainer = color }
	//
	// 	// Tertiary Colors 
	// 	function tertiaryColor(color: color) { colors.tertiary = color }
	// 	function tertiaryContainerColor(color: color) { colors.tertiaryContainer = color }
	// 	function onTertiaryColor(color: color) { colors.topTertiary = color }
	// 	function onTertiaryContainerColor(color: color) { colors.topTertiaryContainer = color }
	//
	// 	// Backgrounds & Surfaces 
	// 	function backgroundColor(color: color) { colors.background = color}
	// 	function onBackgroundColor(color: color) { colors.topBackground = color}
	// 	function surfaceColor(color: color) { colors.surface = color}
	// 	function onSurfaceColor(color: color) { colors.topSurface = color}
	// 	function surfaceVariantColor(color: color) { colors.surfaceVariant = color}
	// 	function onSurfaceVariantColor(color: color) { colors.topSurfaceVariant = color}
	//
	// 	// Outlines & Errors 
	// 	function outlineColor(color: color) { colors.outline = color }
	// 	function outlineVariantColor(color: color) { colors.outlineVariant = color }
	// 	function errorColor(color: color) { colors.error = color }
	}
}
