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

	// this was the most mind numbing thing to type out but is very organized

    // Primary Colors
    property color primary: ColorSheet.values.primaryColors.primary
    property color _onPrimary: ColorSheet.values.primaryColors._onPrimary
    property color primaryContainer: ColorSheet.values.primaryColors.primaryContainer
    property color _onPrimaryContainer: ColorSheet.values.primaryColors._onPrimaryContainer

	property color primaryFixed: ColorSheet.values.primaryFixedColors.primaryFixed
	property color _onPrimaryFixed: ColorSheet.values.primaryFixedColors._onPrimaryFixed
	property color primaryFixedDim: ColorSheet.values.primaryFixedColors.primaryFixedDim 
	property color _onPrimaryFixedVariant: ColorSheet.values.primaryFixedColors._onPrimaryFixedVariant


    // Secondary Colors
    property color secondary: ColorSheet.values.secondaryColors.secondary
    property color _onSecondary: ColorSheet.values.secondaryColors._onSecondary
    property color secondaryContainer: ColorSheet.values.secondaryColors.secondaryContainer
	property color _onSecondaryContainer: ColorSheet.values.secondaryColors._onSecondaryContainer

	property color secondaryFixed: ColorSheet.values.secondaryFixedColors.secondaryFixed
	property color _onSecondaryFixed: ColorSheet.values.secondaryFixedColors._onSecondaryFixed
	property color secondaryFixedDim: ColorSheet.values.secondaryFixedColors.secondaryFixedDim
	property color _onSecondaryFixedVariant: ColorSheet.values.secondaryFixedColors._onSecondaryFixedVariant


    // Tertiary Colors
    property color tertiary: ColorSheet.values.tertiaryColors.tertiary
    property color _onTertiary: ColorSheet.values.tertiaryColors._onTertiary
    property color tertiaryContainer: ColorSheet.values.tertiaryColors.tertiaryContainer
    property color _onTertiaryContainer: ColorSheet.values.tertiaryColors._onTertiaryContainer

	property color tertiaryFixed: ColorSheet.values.tertiaryFixedColors.tertiaryFixed
	property color _onTertiaryFixed: ColorSheet.values.tertiaryFixedColors._onTertiaryFixed 
	property color tertiaryFixedDim: ColorSheet.values.tertiaryFixedColors.tertiaryFixedDim 
	property color _onTertiaryFixedVariant: ColorSheet.values.tertiaryFixedColors._onTertiaryFixedVariant


	// Errors 
	property color error: ColorSheet.values.errorColors.error
	property color _onError: ColorSheet.values.errorColors._onError 
	property color errorContainer: ColorSheet.values.errorColors.errorContianer 
	property color _onErrorContainer: ColorSheet.values.errorColors._onErrorContainer



    // Surfaces
    property color surfaceDim: ColorSheet.values.surfaceColors.surfaceDim
	property color surface: ColorSheet.values.surfaceColors.surface 
	property color surfaceBright: ColorSheet.values.surfaceColors.surfaceBright 

	property color surfaceContainerLowest: ColorSheet.values.surfaceColors.surfaceContainerLowest
	property color surfaceContainerLow: ColorSheet.values.surfaceColors.surfaceContainerLow 
	property color surfaceContainer: ColorSheet.values.surfaceColors.surfaceContainer
	property color surfaceContainerHigh: ColorSheet.values.surfaceColors.surfaceContainerHigh
	property color surfaceContainerHighest: ColorSheet.values.surfaceColors.surfaceContainerHighest 

	property color _onSurface: ColorSheet.values.surfaceColors._onSurface
	property color _onSurfaceVariant: ColorSheet.values.surfaceColors._onSurfaceVariant

	property color outline: ColorSheet.values.surfaceColors.outline 
	property color outlineVariant: ColorSheet.values.surfaceColors.outlineVariant


	// Other Colors (Misc)
	property color inverseSurface: ColorSheet.values.otherColors.inverseSurface
	property color inverseOnSurface: ColorSheet.values.otherColors.inverseOnSurface 

	property color inversePrimary: ColorSheet.values.otherColors.inversePrimary 

	property color scrim: ColorSheet.values.otherColors.scrim
	property color shadow: ColorSheet.values.otherColors.shadow


	// IpcHandler {
	// 	enabled: true 
	// 	target: "colors"
	//
	// 	function applyTheme(themeJsonString: string) {
 //            // Parse the JSON string sent from your shell script
 //            let theme = JSON.parse(themeJsonString);
	//
 //            // Primary Colors
 //            if (theme.primary) colors.primary = theme.primary;
 //            if (theme.primaryContainer) colors.primaryContainer = theme.primaryContainer;
 //            if (theme.topPrimary) colors.topPrimary = theme.topPrimary;
 //            if (theme.topPrimaryContainer) colors.topPrimaryContainer = theme.topPrimaryContainer;
 //            if (theme.primaryContainerBrightness20) colors.primaryContainerBrightness20 = theme.primaryContainerBrightness20;
	//
 //            // Secondary Colors
 //            if (theme.secondary) colors.secondary = theme.secondary;
 //            if (theme.secondaryContainer) colors.secondaryContainer = theme.secondaryContainer;
 //            if (theme.topSecondary) colors.topSecondary = theme.topSecondary;
 //            if (theme.topSecondaryContainer) colors.topSecondaryContainer = theme.topSecondaryContainer;
	//
 //            // Tertiary Colors 
 //            if (theme.tertiary) colors.tertiary = theme.tertiary;
 //            if (theme.tertiaryContainer) colors.tertiaryContainer = theme.tertiaryContainer;
 //            if (theme.topTertiary) colors.topTertiary = theme.topTertiary;
 //            if (theme.topTertiaryContainer) colors.topTertiaryContainer = theme.topTertiaryContainer;
	//
 //            // Backgrounds & Surfaces 
 //            if (theme.background) colors.background = theme.background;
 //            if (theme.topBackground) colors.topBackground = theme.topBackground;
 //            if (theme.surface) colors.surface = theme.surface;
 //            if (theme.topSurface) colors.topSurface = theme.topSurface;
 //            if (theme.surfaceVariant) colors.surfaceVariant = theme.surfaceVariant;
 //            if (theme.topSurfaceVariant) colors.topSurfaceVariant = theme.topSurfaceVariant;
	//
 //            // Outlines & Errors 
 //            if (theme.outline) colors.outline = theme.outline;
 //            if (theme.outlineVariant) colors.outlineVariant = theme.outlineVariant;
            // if (theme.error) colors.error = theme.error;
        // }
	// }
}
