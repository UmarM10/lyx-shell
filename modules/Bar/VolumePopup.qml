import Quickshell
import Quickshell.Services.Pipewire
import QtQuick

import qs

PopupWindow {
    id: root
    anchor.window: rootPanel
    anchor.rect.x: 50
    anchor.rect.y: 1000
    anchor.edges: Edges.Right

    implicitWidth: 200
    implicitHeight: 60
    color: "transparent"

	property string popupState
	visible: popupState === "" || hideTimer.running

	Timer {
		id: hideTimer
		interval: 175
		running: root.popupState == "hidden" ? true : false
		onTriggered: root.popupState === "hidden" && root.visible
	}

    Rectangle {
        id: volumePopupBackground
        anchors.fill: parent
        color: Colors.background
        radius: 10
		state: root.popupState

		// opacity: root.state == "hidden" ? 0.0 : 1.0
		Behavior on opacity {
			NumberAnimation { duration: 200; easing.type: Easing.OutExpo }
		}

        Text {
            color: Colors.primary
            text: Pipewire.defaultAudioSink.audio.muted ? "Volume (Muted)" : "Volume"
            font.family: "Figtree"
            font.pixelSize: 17
            font.weight: 700

            x: 10
            y: 5
        }

        Rectangle {
            id: sliderTrack
            x: 10
            y: 30

            color: Colors.primaryContainer
            radius: 30
            implicitHeight: 20
            implicitWidth: 180

            Rectangle {
                id: activeTrack
                anchors.left: parent.left
                anchors.right: indicatorCircle.horizontalCenter
                height: parent.height
                color: Colors.primary
                topLeftRadius: parent.radius
                bottomLeftRadius: parent.radius
            }

            Rectangle {
                id: indicatorCircle
                radius: 100
                anchors.verticalCenter: parent.verticalCenter
                implicitHeight: 18
                implicitWidth: 18
                color: Colors.background
                x: Pipewire.defaultAudioSink.audio.volume * (parent.width - width)

                Behavior on x {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.OutQuad
                    }
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    color: Colors.primary
                    text: Math.round(Pipewire.defaultAudioSink.audio.volume * 100).toString()
                    font.family: "SF Pro Display"
                    font.pixelSize: text == 100 ? 9 : 11
                    font.weight: 600
                }
            }
		}

		states: [
            State {
                name: "hidden"
                PropertyChanges { target: volumePopupBackground; opacity: 0 }
            },
            State {
                name: "" 
                PropertyChanges { target: volumePopupBackground; opacity: 1 }
            }
        ]

        transitions: [
            Transition {
                NumberAnimation { property: "opacity"; duration: 200 }
            }
        ]
	}
}
