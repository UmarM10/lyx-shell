import Quickshell
import Quickshell.Io
import QtQuick
import Qt5Compat.GraphicalEffects

import qs

// import qs.modules.ControlCenter

PopupWindow {
    id: root
    visible: false
    color: "transparent"
    implicitWidth: 315
    implicitHeight: 450
    anchor.window: rootPanel
    anchor.rect.x: 45
    anchor.rect.y: 585

    function show() {
        showAnimation.restart();
    }
    function hide() {
        hideAnimation.restart();
    }

    Rectangle {
        id: background
        // anchors.fill: parent
        implicitWidth: 300
        implicitHeight: 450
        anchors.bottom: parent.bottom
        x: 15
        color: Colors.background
        radius: 15

        SequentialAnimation {
            id: showAnimation
            running: false
            PropertyAction {
                target: root
                property: "visible"
                value: true
            }
            PropertyAction {
                target: background
                property: "implicitHeight"
                value: 50
            }
            PropertyAction {
                target: background
                property: "x"
                value: 0
            }
            ParallelAnimation {
                NumberAnimation {
                    target: background
                    property: "x"
                    to: 15
                    duration: 300
                    easing.type: Easing.OutCubic
                }
                NumberAnimation {
                    target: background
                    property: "implicitHeight"
                    to: 450
                    duration: 250
                    easing.type: Easing.OutCubic
                }
            }
        }
        SequentialAnimation {
            id: hideAnimation
            NumberAnimation {
                target: background
                property: "implicitHeight"
                to: 0
                duration: 250
                easing.type: Easing.OutCubic
            }
            PropertyAction {
                target: root
                property: "visible"
                value: "false"
            }
        }

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
				anchors.leftMargin: 10
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
				Text {
					id: usernameText
					anchors.verticalCenter: parent.verticalCenter
					text: usernameCollector.text
					color: Colors.primary
					font {
						family: "Figtree"	
						pixelSize: 14
						weight: 700
					}
				}
			}
			
			Row {
				anchors.right: parent.right
				anchors.rightMargin: 10
				anchors.verticalCenter: parent.verticalCenter
				spacing: 4

				Text {
					id: uptimeText
					text: uptimeCollector.text
					color: Colors.primary
					font {
						family: "Figtree"
						pixelSize: 10
						weight: 100
					}
				}
			}
		}
    }
}
