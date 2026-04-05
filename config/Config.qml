pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

import qs

// Do Not Modify This File (unless you know what you're doing); it contains default config values.
// Edit ~/LyxShell/lyxshell.json instead

Singleton {
	id: root
	function write() { configFile.writeAdapter() }
	property alias values: values

	FileView {
		id: configFile
		path: Info.currentUser ? Qt.resolvedUrl(`file:///home/${Info.currentUser}/LyxShell/lyxshell.json`) : undefined
		watchChanges: true 
		onFileChanged: reload()
		onAdapterUpdated: writeAdapter()

		onLoadFailed: (error) => error === FileViewError.FileNotFound ? 
		writeAdapter() :
		console.log(`Failed to write config file: ${error}`)

		blockLoading: false
		preload: true

		adapter: JsonAdapter {
			id: values 

			property int cornerRounding: 20 
			property int screenCornerRounding: 20 
			property real shellOpacity: 1.0

			property int fontWeight: 600 
			property int fontPixelSize: 14
			property string fontFace: "Figtree"
			property string barClockFontFace: "SF Pro Display"
			property int barClockFontWeight: 600
			property string clockFace: "SF Pro Display"
		}
	}
}
