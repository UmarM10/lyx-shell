import Quickshell.Widgets
import Quickshell.Io
import QtQuick
import Qt5Compat.GraphicalEffects

import qs
import qs.common

// Logged in user with uptime and power button	
Rectangle {
	id: root
	anchors.horizontalCenter: parent.horizontalCenter
	// anchors.top: parent.top
	// anchors.topMargin: 8
	implicitWidth: parent.width - 15
	implicitHeight: 32
	color: Colors.primaryContainer
	radius: 12

	property var powerModal
	
	Process {
		// Get Username
		running: true
		command: ["whoami"]
		stdout: StdioCollector { id: usernameCollector }
	}
	Process {
		// Get Uptime
		id: uptimeProcess
		running: true
		command: ["uptime", "-p"]
		stdout: StdioCollector { id: uptimeCollector }
	}
	Timer {
		// Timer to restart uptime process
		interval: 30000
		running: true
		repeat: true
		onTriggered: uptimeProcess.running = true
	}

	Row {
		anchors.left: parent.left
		anchors.leftMargin: 8
		anchors.verticalCenter: parent.verticalCenter
		spacing: 4
		
		ClippingWrapperRectangle {
			radius: 7
			Image {
				id: profilePicture
				source: `/var/lib/AccountsService/icons/${usernameCollector.text.slice(0, -1)}`				
				anchors.verticalCenter: parent.verticalCenter
				sourceSize.width: 21
				sourceSize.height: 21
			}
		}
		LyxText {
			id: usernameText
			anchors.verticalCenter: parent.verticalCenter
			text: usernameCollector.text
			elide: Text.ElideRight
			color: Colors.primary
			font {
				pixelSize: 14
				weight: 600
			}
		}
	}
	
	Row {
		anchors.right: parent.right
		anchors.rightMargin: 8
		anchors.verticalCenter: parent.verticalCenter
		spacing: 4

		LyxText {
			id: uptimeText
			text: uptimeCollector.text
			color: Colors.primary
			anchors.verticalCenter: parent.verticalCenter
			font {
				pixelSize: 10
				weight: 500
			}
		}
		LyxButton {
			id: powerButton
			implicitWidth: 25
			implicitHeight: 25
			MaterialIcon {
				iconId: "plug.svg"
				width: 21
				height: 21
				scale: powerButton.foregroundScale
				color: powerButton.foregroundColor
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.verticalCenter: parent.verticalCenter
			}

			onClicked: root.powerModal.show()
		}
	}
}
