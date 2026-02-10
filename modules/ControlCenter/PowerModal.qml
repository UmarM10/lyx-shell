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
			scale: backButton.foregroundScale
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

				onClicked: shutDownConfirmationModal.show()
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

				onClicked: restartConfirmationModal.show()
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
				
				Process { id: hibernateCommand; command: ["systemctl", "hibernate"] }
				onClicked: hibernateCommand.running = true
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
				implicitWidth: optionsBox.width / 2 - 11

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

				onClicked: lockScreenComingSoonModal.show()
			}

			Separator {
				anchors.verticalCenter: parent.verticalCenter
				orientation: "vertical"
				thickness: 2
				implicitHeight: 70
				color: Colors.primaryContainer
			}

			LyxButton {
				id: logOutButton 
				radius: 15
				anchors.verticalCenter: parent.verticalCenter
				implicitHeight: 80
				implicitWidth: optionsBox.width / 2 - 11

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

				onClicked: logOutConfirmationModal.show()
			}
		}

		Modal {
			id: shutDownConfirmationModal
			modalHeight: 150

			LyxText {
				anchors.centerIn: parent
				anchors.verticalCenterOffset: -25
				horizontalAlignment: Text.AlignHCenter
				text: "Shutting down in\n60 seconds..."
				font.pixelSize: 16
			}

			Row {
				anchors.centerIn: parent
				anchors.verticalCenterOffset: 25
				spacing: 5

				LyxButton {
					implicitWidth: 75
					implicitHeight: 25

					LyxText {
						anchors.centerIn: parent
						text: "Cancel"
						color: parent.foregroundColor
					}

					onClicked: {
						shutDownTimer.stop()
						shutDownConfirmationModal.hide()
					}
				}
				LyxButton {
					implicitWidth: 75
					implicitHeight: 25

					LyxText {
						anchors.centerIn: parent
						text: "Shut Down"
						color: parent.foregroundColor
					}

					onClicked: {
						shutDownTimer.stop()
						shutDownConfirmationModal.hide()
						shutDownCommand.running = true
					}
				}
			}

			Process { id: shutDownCommand; command: ["systemctl", "poweroff"] }

			Timer {
				id: shutDownTimer
				interval: 60000
				running: false 
				repeat: false 
				onTriggered: shutDownCommand.running = true
			}
			onShown: shutDownTimer.restart
		}
		Modal {
			id: restartConfirmationModal 
			modalHeight: 150

			LyxText {
				anchors.centerIn: parent
				anchors.verticalCenterOffset: -25
				horizontalAlignment: Text.AlignHCenter
				text: "Restarting in\n60 seconds..."
				font.pixelSize: 16
			}

			Row {
				anchors.centerIn: parent
				anchors.verticalCenterOffset: 25
				spacing: 5

				LyxButton {
					implicitWidth: 75
					implicitHeight: 25

					LyxText {
						anchors.centerIn: parent
						text: "Cancel"
						color: parent.foregroundColor
					}

					onClicked: {
						restartTimer.stop()
						restartConfirmationModal.hide()
					}
				}
				LyxButton {
					implicitWidth: 75
					implicitHeight: 25

					LyxText {
						anchors.centerIn: parent
						text: "Restart"
						color: parent.foregroundColor
					}

					onClicked: {
						restartTimer.stop()
						restartConfirmationModal.hide()
						restartCommand.running = true
					}
				}
			}

			Process { id: restartCommand; command: ["systemctl", "reboot"] }

			Timer {
				id: restartTimer
				interval: 60000
				running: false 
				repeat: false 
				onTriggered: restartCommand.running = true
			}
			onShown: restartTimer.restart
		}
		Modal {
			id: logOutConfirmationModal 
			modalHeight: 150

			LyxText {
				anchors.centerIn: parent
				anchors.verticalCenterOffset: -25
				horizontalAlignment: Text.AlignHCenter
				text: "Logging out in\n60 seconds..."
				font.pixelSize: 16
			}

			Row {
				anchors.centerIn: parent
				anchors.verticalCenterOffset: 25
				spacing: 5

				LyxButton {
					implicitWidth: 75
					implicitHeight: 25

					LyxText {
						anchors.centerIn: parent
						text: "Cancel"
						color: parent.foregroundColor
					}

					onClicked: {
						logOutTimer.stop()
						logOutConfirmationModal.hide()
					}
				}
				LyxButton {
					implicitWidth: 75
					implicitHeight: 25

					LyxText {
						anchors.centerIn: parent
						text: "Log Out"
						color: parent.foregroundColor
					}

					onClicked: {
						logOutTimer.stop()
						logOutConfirmationModal.hide()
						logOutCommand.running = true
					}
				}
			}

			Process { id: logOutCommand; command: ["loginctl", "terminate-user", "$USER"] }

			Timer {
				id: logOutTimer 
				interval: 60000
				running: false 
				repeat: false 
				onTriggered: logOutCommand.running = true
			}
			onShown: logOutTimer.restart
		}

		Modal {
			id: lockScreenComingSoonModal
			modalHeight: 150

			LyxText {
				anchors.centerIn: parent 
				anchors.verticalCenterOffset: -25
				text: "Lock Screen is still\na work in progress.\nCheck again soon!"
				font.pixelSize: 14
			}
			LyxButton {
				anchors.centerIn: parent
				anchors.verticalCenterOffset: 25
				implicitWidth: 50
				implicitHeight: 25

				LyxText {
					anchors.centerIn: parent 
					text: "Okay"
					color: parent.foregroundColor
				}
				onClicked: lockScreenComingSoonModal.hide()
			}
		}
    }
}
