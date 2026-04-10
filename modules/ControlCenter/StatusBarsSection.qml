// import Quickshell 
import QtQuick

// import qs 
// import qs.common
import qs.services 

Rectangle {
	id: root
	anchors.horizontalCenter: parent.horizontalCenter
	implicitWidth: parent.implicitWidth
	implicitHeight: 60
	color: "transparent"
	radius: 15

	// property int slidersAvailableAfterEssential: {
	// 	let slidersAvailable = 3;
	// 	// if (brightnessSlider.visible) slidersAvailable -= 1;
	// 	// if (batterySlider.visible) slidersAvailable -= 1;
	// 	console.log(`Sliders Available: ${slidersAvailable}`);
	// 	return slidersAvailable;
	// }

	Column {
		spacing: 5
		StatusBar {
			id: volumeSlider
			implicitWidth: root.width
			implicitHeight: 25
			iconId: Audio.iconId
			draggable: true
			dragUpdatesImmediately: true
			displayValue: Audio.defaultSinkAudio.volume
			onIconClicked: Audio.defaultSinkAudio.muted = !Audio.defaultSinkAudio.muted
			onValueUpdatedByDragging: (newValue) => Audio.defaultSinkAudio.volume = newValue
			sliderText: Math.round(Audio.defaultSinkAudio.volume * 100) + "% VOL"
		}
		StatusBar {
			id: brightnessSlider
			// visible: Backlight.deviceCount >= 1
			opacity: Backlight.deviceCount >= 1 ? 1.0 : 0.5
			implicitWidth: root.width 
			implicitHeight: 25 
			iconId: "brightness-7.svg"
			draggable: Backlight.deviceCount >= 1 ? true : false
			dragUpdatesImmediately: false 
			displayValue: Backlight.currentBrightness
			onValueUpdatedByDragging: (newValue) => Backlight.setBrightness(newValue)
			// sliderText: Backlight.deviceCount >= 1 ? Backlight.currentBrightness * 100 + "% BLU" : "NO DEV"
		}
		// StatusBar {
		// 	id: batterySlider
		// 	// visible: Battery.batteryAvailable
		// 	opacity: Battery.batteryAvailable ? 1.0 : 0.0
		// 	implicitWidth: root.width 
		// 	implicitHeight: 25 
		// 	iconId: Battery.iconId 
		// 	draggable: false 
		// 	// displayValue: Battery.defaultBattery.percentage
		// 	displayValue: 0.5	
		// 	sliderText: Battery.defaultBattery.percentage * 100 + "% BAT"
		// }
		//
		// StatusBar {
		// 	id: cpuUsageSlider
		// 	visible: root.slidersAvailableAfterEssential >= 3 
		// 	implicitWidth: root.width 
		// 	implicitHeight: 25 
		// 	iconId: "cpu.svg"
		// 	displayValue: SystemResources.cpuUsagePercent / 100
		// 	sliderText: SystemResources.cpuUsagePercent + "% CPU"
		// }
		// StatusBar {
		// 	id: gpuUsageSlider 
		// 	visible: root.slidersAvailableAfterEssential >= 2
		// 	implicitWidth: root.width 
		// 	implicitHeight: 25 
		// 	iconId: "gpu.svg"
		// 	displayValue: SystemResources.gpuUsagePercent / 100
		// 	sliderText: SystemResources.gpuUsagePercent + "% GPU"
		// }
		// StatusBar {
		// 	id: ramUsageSlider
		// 	visible: root.slidersAvailableAfterEssential >= 1
		// 	implicitWidth: root.width 
		// 	implicitHeight: 25 
		// 	iconId: "memory.svg"
		// 	displayValue: SystemResources.ramUsagePercent / 100
		// 	sliderText: SystemResources.ramUsagePercent + "% RAM"
		// }
	}
}
