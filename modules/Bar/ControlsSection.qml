import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Services.UPower
import QtQuick

import qs
import qs.common

import "./js/controls_bar_section.js" as Logic

Rectangle {
	id: root
	anchors.horizontalCenter: parent.horizontalCenter
	implicitWidth: 35
	implicitHeight: 65
	
	radius: 12
	color: Logic.getBackgroundColor()
	border.width: 2
	border.color: Colors.primaryContainer 

	Behavior on color { ColorAnimation { duration: 100 } }
	Behavior on border.color { ColorAnimation { duration: 100 } }

	// Volume Icon
	MaterialIcon {
		id: volumeIcon
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.top
		anchors.verticalCenterOffset: 15
		height: 19
		width: 19
		color: Colors.primary

		PwObjectTracker {
			objects: Pipewire.nodes.values
		}

		iconId: Logic.getAudioIconPath()
	}

	// Battery/Brightness Icon
	MaterialIcon {
		id: batteryBrightnessIcon
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
		height: 19
		width: 19
		color: Colors.primary

		iconId: Logic.getBatteryIconPath()
	}
	// Charging Icon
	Rectangle {
		id: chargingIcon
		visible: UPower.displayDevice.state == UPowerDeviceState.Charging ? true : false
		x: 3
		y: 30
		radius: 20
		implicitHeight: 10
		implicitWidth: 10
		color: Colors.primaryContainer
		MaterialIcon {
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.verticalCenter: parent.verticalCenter
			height: 8
			width: 8
			color: Colors.primary
			iconId: "bolt.svg"
		}
	}

	// Wi-Fi Icon
	MaterialIcon {
		id: wifiIcon
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.bottom
		anchors.verticalCenterOffset: -15
		height: 19
		width: 19
		color: Colors.primary

		iconId: "network-wifi"
	}

	MaterialIcon {
		id: closeIcon
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
		height: 20
		width: 20
		color: Colors.primary
		iconId: "close.svg"
		visible: false
	}

	states: [
		State {
			name: "pressed"
			PropertyChanges {
				volumeIcon { visible: false; }
				batteryBrightnessIcon { visible: false; }
				chargingIcon { visible: false; }
				wifiIcon { visible: false; }
				closeIcon { visible: true; }
			}
		}
	]
	state: ""

	MouseArea {
		id: mouseArea
		anchors.fill: parent
		hoverEnabled: true
		onClicked: onClickedFunc()
	}
	function onClickedFunc() {
		if (root.state == "")
			pressedAnimation.restart()
		else
			root.state = ""
	}
	SequentialAnimation {
		id: pressedAnimation	
		running: false
		ParallelAnimation {
			NumberAnimation { target: volumeIcon; property: "scale"; to: 0.75; duration: 75; easing.type: Easing.OutQuad }
			NumberAnimation { target: wifiIcon; property: "scale"; to: 0.75; duration: 75; easing.type: Easing.OutQuad }
			NumberAnimation { target: batteryBrightnessIcon; property: "scale"; to: 0.75; duration: 75; easing.type: Easing.OutQuad }
		}
		ParallelAnimation {
			NumberAnimation { target: volumeIcon; property: "anchors.verticalCenterOffset"; to: 27; duration: 150; easing.type: Easing.OutCubic }
			NumberAnimation { target: wifiIcon; property: "anchors.verticalCenterOffset"; to: -27; duration: 150; easing.type: Easing.OutCubic }
		}
		PropertyAction { target: root; property: "state"; value: "pressed" }
		// Reset
		PropertyAction { target: volumeIcon; property: "anchors.verticalCenterOffset"; value: 15 }
		PropertyAction { target: volumeIcon; property: "scale"; value: 1 }
		PropertyAction { target: wifiIcon; property: "anchors.verticalCenterOffset"; value: -15 }
		PropertyAction { target: wifiIcon; property: "scale"; value: 1 }
		PropertyAction { target: batteryBrightnessIcon; property: "scale"; value: 1 }
	}
}
