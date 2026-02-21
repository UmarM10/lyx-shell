import Quickshell.Widgets
import Quickshell.Io
import QtQuick

import qs 
import qs.common
import qs.services

Rectangle {
	id: root 
	anchors.horizontalCenter: parent.horizontalCenter 
	implicitWidth: parent.implicitWidth
	implicitHeight: 200
	color: "transparent" 
	radius: 15

	// border.width: 3 
	// border.color: Colors.primaryContainer

	ToggleButton {
		id: wifiToggle
		anchors.top: parent.top 
		anchors.left: parent.left
		implicitWidth: 120
		implicitHeight: 50
		radius: 10
		border.width: toggled ? 0 : 2
		border.color: Colors.primaryContainer

		toggled: Network.isConnected
		onClicked: Network.toggleWifi()

		MaterialIcon {
			anchors.left: parent.left 
			anchors.leftMargin: 15
			anchors.verticalCenter: parent.verticalCenter 
			iconId: Network.iconId
			color: wifiToggle.foregroundColor
			width: 21 
			height: 21
		}
		LyxText {
			anchors.verticalCenter: parent.verticalCenter 
			anchors.left: parent.left 
			anchors.leftMargin: 45
			anchors.verticalCenterOffset: wifiToggle.toggled ? -7 : 0
			color: parent.foregroundColor 
			text: "Network"
			font.pixelSize: 14

			Behavior on anchors.verticalCenterOffset {
				NumberAnimation { duration: 50; easing.type: Easing.OutQuad }
			}
		}
		LyxText {
			id: wifiSsidText
			anchors.verticalCenter: parent.verticalCenter 
			anchors.left: parent.left 
			anchors.leftMargin: 45 
			anchors.verticalCenterOffset: 8
			color: parent.foregroundColor 
			elide: Text.ElideRight
			width: parent.width / 1.8
			font.pixelSize: 10
			opacity: wifiToggle.toggled ? 1.0 : 0
			Behavior on opacity {
				NumberAnimation { duration: 100; easing.type: Easing.OutQuad }
			}

			text: Network.currentSSID
		}
	}

	ToggleButton {
		id: bluetoothToggle
		anchors.top: parent.top 
		anchors.topMargin: 55
		anchors.left: parent.left
		implicitWidth: 120
		implicitHeight: 50
		radius: 10
		border.width: toggled ? 0 : 2
		border.color: Colors.primaryContainer

		automaticallyToggle: false
		toggled: Bluetooth.state
		onClicked: Bluetooth.toggle()

		MaterialIcon {
			anchors.left: parent.left 
			anchors.leftMargin: 15
			anchors.verticalCenter: parent.verticalCenter 
			iconId: "bluetooth.svg"
			color: bluetoothToggle.foregroundColor
			width: 21 
			height: 21
		}
		LyxText {
			anchors.verticalCenter: parent.verticalCenter 
			anchors.left: parent.left 
			anchors.leftMargin: 45
			anchors.verticalCenterOffset: bluetoothToggle.toggled ? -7 : 0
			color: parent.foregroundColor 
			text: "Bluetooth"
			font.pixelSize: 14

			Behavior on anchors.verticalCenterOffset {
				NumberAnimation { duration: 50; easing.type: Easing.OutQuad }
			}
		}
		LyxText {
			id: bluetoothConnectedDevicesText
			anchors.verticalCenter: parent.verticalCenter 
			anchors.left: parent.left 
			anchors.leftMargin: 45 
			anchors.verticalCenterOffset: 8
			color: parent.foregroundColor 
			elide: Text.ElideRight
			width: parent.width / 1.8
			text: `${Bluetooth.connectedDevices} connected`
			font.pixelSize: 10
			opacity: bluetoothToggle.toggled ? 1.0 : 0
			Behavior on opacity {
				NumberAnimation { duration: 100; easing.type: Easing.OutQuad }
			}
		}
	}
	ToggleButton {
		id: caffeineToggle
		anchors.top: parent.top 
		anchors.topMargin: 110
		anchors.left: parent.left
		implicitWidth: 120
		implicitHeight: 50
		radius: 10
		border.width: toggled ? 0 : 2
		border.color: Colors.primaryContainer

		// automaticallyToggle: false

		Process {
			id: caffeineProc 
			command: ["caffeine"]
			running: caffeineToggle.toggled ? true : false
		}

		MaterialIcon {
			anchors.left: parent.left 
			anchors.leftMargin: 15
			anchors.verticalCenter: parent.verticalCenter 
			iconId: "coffee.svg"
			color: caffeineToggle.foregroundColor
			width: 21 
			height: 21
		}
		LyxText {
			anchors.verticalCenter: parent.verticalCenter 
			anchors.left: parent.left 
			anchors.leftMargin: 45
			anchors.verticalCenterOffset: caffeineToggle.toggled ? -7 : 0
			color: parent.foregroundColor 
			text: "Caffeine"
			font.pixelSize: 14

			Behavior on anchors.verticalCenterOffset {
				NumberAnimation { duration: 50; easing.type: Easing.OutQuad }
			}
		}
		LyxText {
			anchors.verticalCenter: parent.verticalCenter 
			anchors.left: parent.left 
			anchors.leftMargin: 45 
			anchors.verticalCenterOffset: 8
			color: parent.foregroundColor 
			elide: Text.ElideRight
			width: parent.width / 1.8
			text: "Disabled sleep"
			font.pixelSize: 10
			opacity: caffeineToggle.toggled ? 1.0 : 0
			Behavior on opacity {
				NumberAnimation { duration: 100; easing.type: Easing.OutQuad }
			}
		}
	} 


	ClippingRectangle {
		id: volumeSlider 
		anchors.top: parent.top 
		anchors.horizontalCenter: parent.horizontalCenter 
		anchors.horizontalCenterOffset: 10
		implicitWidth: 45
		implicitHeight: 160
		border.width: 2 
		border.color: Colors.primaryContainer
		color: Colors.topPrimary
		radius: 20

		Rectangle {
			id: sliderIndicator
			anchors.horizontalCenter: parent.horizontalCenter 
			y: 120 - Audio.defaultSinkAudio.volume * 100
			// y: 0
			color: Colors.primary 
			implicitWidth: parent.width
			implicitHeight: 35 
			radius: 20

			Behavior on y {
				NumberAnimation { duration: 100; easing.type: Easing.OutQuad }
			}

			MaterialIcon {
				iconId: Audio.iconId
				anchors.centerIn: parent
				color: Colors.background 
				width: 21 
				height: 21
			}

			MouseArea {
				anchors.fill: parent 
				hoverEnabled: true 
				onPressed: parent.y = mouseY
				onReleased: parent.y = mouseY
			}
		}

		Rectangle {
			id: activeSlider 
			anchors.top: sliderIndicator.verticalCenter
			// anchors.bottom: volumeSlider.bottom
			color: Colors.primary
			implicitWidth: parent.width 
			implicitHeight: 200
			z: -1
		}
	}
}
