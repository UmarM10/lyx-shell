import QtQuick 

import qs 
import qs.config
import qs.services
import qs.common

CollapsibleSection {
	id: root
	anchors.horizontalCenter: parent.horizontalCenter 

	Column {
		spacing: 7
		anchors.top: parent.top 
		anchors.left: parent.left 
		anchors.topMargin: 3.5
		anchors.leftMargin: 10
		Row {
			spacing: 4
			MaterialIcon {
				iconId: Battery.batteryAvailable ? Battery.iconId : "battery-full.svg"
				anchors.verticalCenter: parent.verticalCenter
				width: 25 
				height: 25 
				color: Colors.primary
			}
			LyxText {
				id: title 
				anchors.verticalCenter: parent.verticalCenter
				text: {
					if (Battery.batteryAvailable) {
						return `Battery - ${Math.round(Battery.defaultBattery.percentage * 100)}% remaining.`
					} else return "No Battery Detected"
				}
			}
		}
		LyxText {
			id: remainingText
			visible: Battery.batteryAvailable && !root.collapsed
			usePercentSize: true 
			percentSize: 0.75
			weightModifier: -200
			text: `${Math.trunc(Battery.defaultBattery.timeToEmpty / 3600)} hours and ${Math.trunc(Battery.defaultBattery.timeToEmpty / 60)} minutes remaining.`
		}

		Row {
			id: powerProfilesSwitcher 
			visible: !root.collapsed
			Rectangle {
				implicitWidth: 99
				implicitHeight: 30
				z: -1
				radius: Config.values.cornerRounding
				color: Colors.primary

				Rectangle {
					id: activeProfile
					z: 0
					x: 66
					anchors.verticalCenter: parent.verticalCenter
					implicitWidth: 33
					implicitHeight: 30
					radius: 33
					color: Colors.topPrimary
					border.width: 1
					border.color: Colors.topPrimary

					property var currentProfile
					onCurrentProfileChanged: PowerProfiles.set(currentProfile)

					state: "performance"
					states: [
						State {
							name: "powerSaving"
							PropertyChanges {
								activeProfile { x: 0; currentProfile: "powerSaver" }
								powerSavingIcon { color: Colors.topPrimaryContainer }
							}
						},
						State {
							name: "balanced"
							PropertyChanges {
								activeProfile { x: 33; currentProfile: "balanced" }
								balancedIcon { color: Colors.topPrimaryContainer }
							}
						},
						State {
							name: "performance"
							PropertyChanges {
								activeProfile { x: 66; currentProfile: "performance" }
								performanceIcon { color: Colors.topPrimaryContainer }
							}
						},
					]
					
					Behavior on x { NumberAnimation { duration: 250; easing.type: Easing.OutExpo } }
				}

				MaterialIcon {
					id: powerSavingIcon 
					anchors.verticalCenter: parent.verticalCenter 
					anchors.left: parent.left 
					anchors.leftMargin: 4
					width: 24 
					height: 24
					iconId: "power-saving-leaf.svg"
					color: Colors.background
				}
				MouseArea {
					x: 0 
					implicitWidth: 33
					implicitHeight: parent.height
					anchors.verticalCenter: parent.verticalCenter
					onClicked: activeProfile.state = "powerSaving"
					cursorShape: Qt.PointingHandCursor
				}

				MaterialIcon {
					id: balancedIcon
					anchors.centerIn: parent
					width: 24 
					height: 24
					iconId: "balance.svg"
					// color: activeProfile.state === "balanced" ? Colors.topPrimaryContainer : Colors.background
					color: Colors.background
				}
				MouseArea {
					x: 33
					implicitWidth: 33
					implicitHeight: parent.height
					anchors.verticalCenter: parent.verticalCenter
					onClicked: activeProfile.state = "balanced"
					cursorShape: Qt.PointingHandCursor
				}

				MaterialIcon {
					id: performanceIcon
					anchors.verticalCenter: parent.verticalCenter
					anchors.right: parent.right 
					anchors.rightMargin: 4
					width: 24 
					height: 24
					iconId: "rocket.svg"
					// color: activeProfile.state === "performance" ? Colors.topPrimaryContainer : Colors.background
					color: Colors.background
				}
				MouseArea {
					x: 66
					implicitWidth: 33
					implicitHeight: parent.height
					anchors.verticalCenter: parent.verticalCenter
					onClicked: activeProfile.state = "performance"
					cursorShape: Qt.PointingHandCursor
				}
			}

			spacing: 5

			LyxText {
				anchors.verticalCenter: parent.verticalCenter
				text: PowerProfiles.currentProfile
			}
		}
	}
}
