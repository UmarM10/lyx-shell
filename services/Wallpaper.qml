pragma Singleton

import Quickshell 
import QtQuick 

Singleton {
	id: root 

	// Properties 
	property url currentPath: "/home/UmarM/Pictures/Wallpapers/Leaves.jpg"
	readonly property bool animated: currentPath.toString().endsWith(".gif")
	readonly property string colorScheme: "dark"
	// Signals
	signal changed()
	// Methods
	function set(newPath) { currentPath = newPath }

	onCurrentPathChanged: { changed() }
}
