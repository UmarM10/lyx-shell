pragma Singleton

import Quickshell 
import QtQuick 

import qs

Singleton {
	id: root 

	// Properties 
	// property url currentPath: "/home/UmarM/Pictures/Wallpapers/Lake & Mountains.jpg"
	property url currentPath: ShellState.values.currentWallpaperPath
	onCurrentPathChanged: {
		ShellState.values.currentWallpaperPath = currentPath;
		changed();
	}
	readonly property bool animated: currentPath.toString().endsWith(".gif")
	readonly property string colorScheme: "dark" // Colorscheme from wallpaper. Not completed logic; this is a placeholder
	readonly property string rawPath: {
        let pathStr = currentPath.toString();
        return pathStr.replace(/^file:\/\//, "");
    }

	// Signals
	signal changed()

	// Methods
	function set(newPath) { currentPath = newPath }
}
