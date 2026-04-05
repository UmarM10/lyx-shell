pragma Singleton 

import Quickshell 
import QtQuick
import Quickshell.Io 

Singleton {
	id: root 
	function write() { stateFile.writeAdapter() }
	property alias values: values

	FileView {
		id: stateFile
		path: `${Quickshell.shellDir}/shellstate.json`
		watchChanges: false 
		onAdapterUpdated: writeAdapter()
		blockLoading: false 
		preload: true 
		onLoadFailed: (error) => error === FileViewError.FileNotFound ? 
		writeAdapter() :
		console.log(`Failed to write shellstate file: ${error}`)

		adapter: JsonAdapter {
			id: values

			property url currentWallpaperPath: Qt.resolvedUrl("assets/simple-background-blue.jpg")
			property string colorSchemeMode: "dark" // "wallpaper", "dark", or "light" (soon to be auto)
			property string colorType: "scheme-tonal-spot"
			// "scheme-tonal-spot" (default), "scheme-content", "scheme-expressive", "scheme-fidelity",
			// "scheme-fruit-salad", "scheme-monochrome", "scheme-neutral", "scheme-rainbow", "scheme-vibrant"
		}
	}
}
