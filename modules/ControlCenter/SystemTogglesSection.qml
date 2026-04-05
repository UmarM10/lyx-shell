// import Quickshell.Widgets
import Quickshell.Io
import QtQuick

// import qs 
// import qs.common
import qs.services

Rectangle {
	id: root 
	anchors.horizontalCenter: parent.horizontalCenter 
	implicitWidth: parent.implicitWidth
	implicitHeight: 105
	color: "transparent" 
	radius: 15

	ControlCenterToggle {
		anchors.top: parent.top 
		anchors.left: parent.left 

		toggled: Network.isConnected 
		onClicked: Network.toggleWifi()

		iconId: Network.iconId
		title: "Network"
		toggledSubtitle: Network.currentSSID
	}

	ControlCenterToggle {
		anchors.left: parent.left 
		anchors.top: parent.top 
		anchors.topMargin: 55

		automaticallyToggle: false 
		toggled: Bluetooth.state 
		onClicked: Bluetooth.toggle()

		iconId: Bluetooth.iconId
		title: "Bluetooth" 
		toggledSubtitle: `${Bluetooth.connectedDevices} connected`
	}

	ControlCenterToggle {
		id: caffeineToggle
		anchors.right: parent.right
		anchors.top: parent.top 

		Process {
			id: caffeineProc 
			command: ["caffeine"]
			running: caffeineToggle.toggled ? true : false
		}

		title: "Caffeine" 
		toggledSubtitle: "Keeping awake"
		iconId: "coffee.svg"
	}

	ControlCenterToggle {
		anchors.right: parent.right
		anchors.top: parent.top 
		anchors.topMargin: 55

		automaticallyToggle: true

		iconId: toggled ? "dndon.svg" : "dndoff.svg"
		title: "DND" 
		toggledSubtitle: "Do Not Disturb"
	}
}
