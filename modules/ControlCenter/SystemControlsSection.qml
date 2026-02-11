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
}
