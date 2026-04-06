pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import qs.services
import qs

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
		running: ShellState.loaded ? false : true
		command: [
			"matugen", "image", Wallpaper.rawPath,
			"--mode", colors.colorScheme, 
			"--type", colors.colorType, 
			"--source-color-index", 0
		]
		stdout: StdioCollector { id: matugenOutput }
		onExited: (exitCode) => console.log(`Matugen ran. Command: ${command} Exit Code: ${exitCode}`)
	}

	Connections {
		target: Wallpaper

		function onCurrentPathChanged() {
			colorUpdater.running = true;
		}
	}


    // Primary Colors
    property color primary: "#83d5c5"
    // property color primaryLight: "#006b5e"
    // property color primaryDark: "#83d5c5"
    property color topPrimary: "#003730"
    property color primaryContainer: "#005046"
	property color primaryContainerBrightness20: "#009d89"
    // property color primaryContainerLight: "#9ff2e1"
    // property color primaryContainerDark: "#005046"
    property color primaryContainerVariant: { 
		Wallpaper.colorScheme === "dark" ?
		Qt.darker(primaryContainer, 2.0) : 
		primaryContainerBrightness20
	}
    property color topPrimaryContainer: "#9ff2e1"

    // Secondary Colors
    property color secondary: "#b1ccc5"
    property color topSecondary: "#1c3530"
    property color secondaryContainer: "#334b46"
    property color topSecondaryContainer: "#cde8e1"

    // Tertiary Colors
    property color tertiary: "#accae5"
    property color topTertiary: "#133348"
    property color tertiaryContainer: "#2c4a60"
    property color topTertiaryContainer: "#cae6ff"

    // Backgrounds & Surfaces
    property color background: "#0e1513"
    property color topBackground: "#dee4e1"
    property color surface: "#0e1513"
    property color topSurface: "#dee4e1"
    property color surfaceVariant: "#3f4946"
    property color topSurfaceVariant: "#bec9c5"
    
    // Outlines & Errors
    property color outline: "#899390"
    property color outlineVariant: "#3f4946"
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
