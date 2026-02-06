import Quickshell
import Quickshell.Io
import QtQuick

import qs
import qs.common

Modal {
    id: root

    LyxButton {
        id: backButton
        implicitWidth: 30
        implicitHeight: 30
        radius: 15
        anchors.left: parent.left
        anchors.leftMargin: 20
        y: 10

        MaterialIcon {
            anchors.centerIn: parent
            color: backButton.foregroundColor
            iconId: "arrow-back.svg"
			width: 26
			height: 26
        }

        onClicked: root.hide()
    }

    LyxText {
        font.pointSize: 14
        font.weight: 600
        anchors.horizontalCenter: parent.horizontalCenter
		anchors.horizontalCenterOffset: 5
        anchors.top: parent.top
        anchors.topMargin: 13
        text: "Power Options"
    }

    Rectangle {
        id: optionsBox
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 10
        implicitWidth: 200
        implicitHeight: 290
        color: Colors.primaryContainerVariant
        radius: 15
        border.width: 2
        border.color: Colors.primaryContainer

        Column {
            id: buttonStack
            anchors.fill: parent
            anchors.margins: 5
            anchors.topMargin: 6
            spacing: 4

            LyxButton {
                id: sleepButton 
                anchors.horizontalCenter: parent.horizontalCenter
                implicitWidth: parent.width
                implicitHeight: 40
                radius: 10

                Row {
                    anchors.centerIn: parent
                    spacing: 5

                    MaterialIcon {
                        iconId: "moon.svg"
                        anchors.verticalCenter: parent.verticalCenter
                        color: sleepButton.foregroundColor
                        width: 18
                        height: 18
                    }
                    LyxText {
                        anchors.verticalCenter: parent.verticalCenter
                        text: "Sleep"
                        font.pointSize: 12
                        color: sleepButton.foregroundColor
                    }
                }

				Process { id: sleepCommand; running: false; command: ["systemctl", "suspend"] }
				onClicked: sleepCommand.running = true
            }
			Separator {
				implicitWidth: parent.width
				color: Colors.primaryContainer
			}
			LyxButton {
                id: shutDownButton
                anchors.horizontalCenter: parent.horizontalCenter
                implicitWidth: parent.width
                implicitHeight: 40
                radius: 10

                Row {
                    anchors.centerIn: parent
                    spacing: 5

                    MaterialIcon {
                        iconId: "power.svg"
                        anchors.verticalCenter: parent.verticalCenter
                        color: shutDownButton.foregroundColor
                        width: 18
                        height: 18
                    }
                    LyxText {
                        anchors.verticalCenter: parent.verticalCenter
                        text: "Shut Down"
                        font.pointSize: 12
                        color: shutDownButton.foregroundColor
                    }
                }
            }
			Separator {
				implicitWidth: parent.width
				color: Colors.primaryContainer
			}
			LyxButton {
                id: restartButton
                anchors.horizontalCenter: parent.horizontalCenter
                implicitWidth: parent.width
                implicitHeight: 40
                radius: 10

                Row {
                    anchors.centerIn: parent
                    spacing: 5

                    MaterialIcon {
                        iconId: "restart.svg"
                        anchors.verticalCenter: parent.verticalCenter
                        color: restartButton.foregroundColor
                        width: 18
                        height: 18
                    }
                    LyxText {
                        anchors.verticalCenter: parent.verticalCenter
                        text: "Restart"
                        font.pointSize: 12
                        color: restartButton.foregroundColor
                    }
                }
            }
			Separator {
				implicitWidth: parent.width
				color: Colors.primaryContainer
			}
			LyxButton {
                id: hibernateButton 
                anchors.horizontalCenter: parent.horizontalCenter
                implicitWidth: parent.width
                implicitHeight: 40
                radius: 10

                Row {
                    anchors.centerIn: parent
                    spacing: 5

                    MaterialIcon {
                        iconId: "clock.svg"
                        anchors.verticalCenter: parent.verticalCenter
                        color: hibernateButton.foregroundColor
                        width: 18
                        height: 18
                    }
                    LyxText {
                        anchors.verticalCenter: parent.verticalCenter
                        text: "Hibernate"
                        font.pointSize: 12
                        color: hibernateButton.foregroundColor
                    }
                }
            }
			Separator {
				implicitWidth: parent.width
				color: Colors.primaryContainer
			}
        }


		Row {
			id: sessionButtonSplit
			anchors.bottom: parent.bottom
			anchors.margins: 5
			x: 5
			spacing: 5

			LyxButton {
				id: lockButton
				radius: 15
				anchors.verticalCenter: parent.verticalCenter
				implicitHeight: 80
				implicitWidth: optionsBox.width / 2 - 5

				Column {
					anchors.centerIn: parent
					spacing: 5
					MaterialIcon {
						iconId: "lock.svg"
						anchors.horizontalCenter: parent.horizontalCenter
						color: lockButton.foregroundColor
						width: 30
						height: 30
					}
					LyxText {
						anchors.horizontalCenter: parent.horizontalCenter
						color: lockButton.foregroundColor
						font.pointSize: 12
						text: "Lock"
					}
				}
			}
			LyxButton {
				id: logOutButton 
				radius: 15
				anchors.verticalCenter: parent.verticalCenter
				implicitHeight: 80
				implicitWidth: optionsBox.width / 2 - 10

				Column {
					anchors.centerIn: parent
					spacing: 5
					MaterialIcon {
						iconId: "logout.svg"
						anchors.horizontalCenter: parent.horizontalCenter
						color: logOutButton.foregroundColor
						width: 30
						height: 30
					}
					LyxText {
						anchors.horizontalCenter: parent.horizontalCenter
						color: logOutButton.foregroundColor
						font.pointSize: 12
						text: "Log Out"
					}
				}
			}
		}
    }
}
