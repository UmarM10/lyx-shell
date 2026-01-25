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
	color: Colors.primaryContainerVariant
	border.width: 2
	border.color: Colors.primaryContainer

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
}
