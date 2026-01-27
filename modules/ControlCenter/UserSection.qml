import Quickshell.Io
import QtQuick
import Qt5Compat.GraphicalEffects

import qs
import qs.common

// Logged in user with uptime and power button	
Rectangle {
	anchors.horizontalCenter: parent.horizontalCenter
	anchors.top: parent.top
	anchors.topMargin: 8
	implicitWidth: 285
	implicitHeight: 32
	color: Colors.primaryContainer
	radius: 12
	
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

		Image {
			id: profilePicture
			source: `/var/lib/AccountsService/icons/${usernameCollector.text.slice(0, -1)}`				
			anchors.verticalCenter: parent.verticalCenter
			sourceSize.width: 21
			sourceSize.height: 21
			layer.enabled: true
			layer.effect: OpacityMask {
				maskSource: Rectangle {
					width: profilePicture.sourceSize.width
					height: profilePicture.height
					radius: 7
				}
			}
		}
		LyxText {
			id: usernameText
			anchors.verticalCenter: parent.verticalCenter
			text: usernameCollector.text
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
				color: powerButton.foregroundColor
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.verticalCenter: parent.verticalCenter
			}
		} 
	}
}
