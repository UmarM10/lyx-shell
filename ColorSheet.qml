pragma Singleton 

import QtQuick 
import Quickshell 
import Quickshell.Io

import qs.services
import qs

Singleton {
	id: root 
	property bool loaded
	property alias values: values
	
	FileView {
		id: colorSheet
		path: `${Quickshell.shellDir}/colorsheet.json`
		watchChanges: true 
		onFileChanged: reload()
		blockLoading: false
		preload: true
		onLoadFailed: (error) => 
		error === FileViewError.FileNotFound ? 
		writeAdapter() :
		console.log(`Failed to load colorsheet - Error Code:  ` + error)

		adapter: JsonAdapter {
			id: values
			
			property JsonObject primaryColors: JsonObject {
				property color primary
				property color _onPrimary
				property color primaryContainer 
				property color _onPrimaryContainer
			}
			property JsonObject primaryFixedColors: JsonObject {
				property color primaryFixed
				property color _onPrimaryFixed
				property color primaryFixedDim 
				property color _onPrimaryFixedVariant
			}

			property JsonObject secondaryColors: JsonObject {
				property color secondary
				property color _onSecondary 
				property color secondaryContainer 
				property color _onSecondaryContainer
			}
			property JsonObject secondaryFixedColors: JsonObject {
				property color secondaryFixed
				property color _onSecondaryFixed
				property color secondaryFixedDim 
				property color _onSecondaryFixedVariant
			}

			property JsonObject tertiaryColors: JsonObject {
				property color tertiary
				property color _onTertiary
				property color tertiaryContainer
				property color _onTertiaryContainer
			}
			property JsonObject tertiaryFixedColors: JsonObject {
				property color tertiaryFixed
				property color _onTertiaryFixed
				property color tertiaryFixedDim
				property color _onTertiaryFixedVariant
			}

			property JsonObject errorColors: JsonObject {
				property color error
				property color _onError
				property color errorContainer
				property color _onErrorContainer
			}

			property JsonObject surfaceColors: JsonObject {
				property color surfaceDim
				property color surface
				property color surfaceBright

				property color surfaceContainerLowest
				property color surfaceContainerLow
				property color surfaceContainer
				property color surfaceContainerHigh
				property color surfaceContainerHighest

				property color _onSurface
				property color _onSurfaceVariant

				property color outline
				property color outlineVariant
			}

			property JsonObject otherColors: JsonObject {
				property color inverseSurface 
				property color inverseOnSurface
				
				property color inversePrimary

				property color scrim
				property color shadow
			}
		}
	}
}
