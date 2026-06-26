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
	property alias general: general
	property alias values: general // Legacy

	property alias bar: general.bar
	property alias controlCenter: general.controlCenter
	property alias dashboard: general.dashboard


	FileView {
		id: configFile
		path: Info.currentUser ? Qt.resolvedUrl(`${Info.currentHome}/evolyx/lyxshell.json`) : undefined
		watchChanges: true 
		onFileChanged: reload()
		onAdapterUpdated: writeAdapter()

		onLoadFailed: (error) => error === FileViewError.FileNotFound ? 
		writeAdapter() :
		console.log(`Failed to write config file: ${error}`)

		blockLoading: false
		preload: true

		adapter: JsonAdapter {
			id: general 

			property int cornerRounding: 20 
			property int screenCornerRounding: 20 
			property real shellOpacity: 1.0

			property int fontWeight: 600 
			property int fontPixelSize: 16
			property string fontFace: "Figtree"
			property string clockFontFace: "SF Pro Display"

			property JsonObject bar: BarConfig {
				id: bar
			}
			property JsonObject controlCenter: ControlCenterConfig {
				id: controlCenter
			}
			property JsonObject dashboard: DashboardConfig {
				id: dashboard
			}
		}
	}
}
