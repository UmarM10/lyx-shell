pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import qs.services
import qs

Singleton {
    id: colors

	property string colorSchemeMode: ShellState.values.colorSchemeMode // Wallpaper, dark, or light
	readonly property string colorScheme: {
		if (colorSchemeMode === "wallpaper") {
			return Wallpaper.colorScheme
		} else return colorSchemeMode
	}
	property string colorType: ShellState.values.colorType

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
    property color primary: "#c5c0ff"
    // property color primaryLight: "#5c5891"
    // property color primaryDark: "#c5c0ff"
    property color topPrimary: "#2d2960"
    property color primaryContainer: "#444078"
	property color primaryContainerBrightness20: "#625ca8"
    // property color primaryContainerLight: "#e3dfff"
    // property color primaryContainerDark: "#444078"
    property color primaryContainerVariant: { 
		Wallpaper.colorScheme === "dark" ?
		Qt.darker(primaryContainer, 2.0) : 
		primaryContainerBrightness20
	}
    property color topPrimaryContainer: "#e3dfff"

    // Secondary Colors
    property color secondary: "#c7c4dc"
    property color topSecondary: "#302e42"
    property color secondaryContainer: "#464559"
    property color topSecondaryContainer: "#e4dff9"

    // Tertiary Colors
    property color tertiary: "#ebb9d0"
    property color topTertiary: "#472538"
    property color tertiaryContainer: "#603b4f"
    property color topTertiaryContainer: "#ffd8e9"

    // Backgrounds & Surfaces
    property color background: "#131318"
    property color topBackground: "#e5e1e9"
    property color surface: "#131318"
    property color topSurface: "#e5e1e9"
    property color surfaceVariant: "#47464f"
    property color topSurfaceVariant: "#c8c5d0"
    
    // Outlines & Errors
    property color outline: "#928f99"
    property color outlineVariant: "#47464f"
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
