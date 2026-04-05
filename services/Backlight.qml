pragma Singleton 

import Quickshell 
import Quickshell.Io
import QtQuick 

Singleton {
	readonly property int deviceCount: getDeviceCount()
	readonly property real currentBrightness: currentBrightnessCollector.text
	readonly property real maxBrightness: maximumBrightnessCollector.text
	function setBrightness(newValue) {
		brightnessSetter.newBrightness = newValue;
		brightnessSetter.running = true;
	}


	Timer {
		id: valueUpdater 
		interval: 250 
		onTriggered: {
			brightnessInfoCollector.running = true; 
			currentBrightnesssProc.running = true; 
			maximumBrightnessProc.running = true; 
		}
	}
	// Get Number of Backlight Devices
	Process {
		id: brightnessInfoProc
		running: true
		command: ["sh", "-c", "brightnessctl info | grep -c 'class: backlight'"]
		stdout: StdioCollector { id: brightnessInfoCollector }
	}
	function getDeviceCount() {
		return brightnessInfoCollector.text.split("Device").length - 1
	}

	// Get Current Brightness 
	Process {
		id: currentBrightnesssProc
		running: true 
		command: ["brightnessctl", "get"]
		stdout: StdioCollector { id: currentBrightnessCollector }
	}

	// Get Maximum Brightness 
	Process {
		id: maximumBrightnessProc
		running: true
		command: ["brightnessctl", "max"]
		stdout: StdioCollector { id: maximumBrightnessCollector }
	}
	
	// Setter 
	Process {
		id: brightnessSetter
		property real newBrightness
		command: ["brightnessctl", "set", newBrightness]
	}
}
