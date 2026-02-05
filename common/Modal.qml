import Quickshell.Widgets
import QtQuick

import qs

// Modal
Rectangle {
	id: root
	anchors.fill: parent
	color: "transparent"
	visible: false

	function show() { showAnimation.restart() }
	function hide() { hideAnimation.restart() }

	Rectangle {
		id: background
		anchors.fill: parent
		color: "black"
		opacity: 0.8

		MouseArea {
			id: backgroundMouseArea
			anchors.fill: background
			onClicked: hideAnimation.restart()
		}
	}

	default property alias children: foreground.data

	Rectangle {
		id: foreground
		anchors.centerIn: parent
		color: Colors.background
		implicitHeight: parent.height / 1.2
		implicitWidth: parent.width / 1.2
		radius: 20

		MouseArea { id: foregroundMouseArea; anchors.fill: parent }
	}

	SequentialAnimation {
		id: showAnimation
		running: false

		PropertyAction { target: foreground; property: "scale"; value: 0.3 }
		PropertyAction { target: foreground; property: "opacity"; value: 0 }
		PropertyAction { target: background; property: "opacity"; value: 0 }
		PropertyAction { target: root; property: "visible"; value: true }
		ParallelAnimation {
			NumberAnimation {
				target: foreground
				property: "scale"
				to: 1.0
				duration: 200
				easing.type: Easing.OutCirc
			}
			OpacityAnimator {
				target: foreground
				to: 1.0
				duration: 100
			}
			OpacityAnimator {
				target: background 
				to: 0.8
				duration: 200
			}
		}
	}

	SequentialAnimation {
		id: hideAnimation
		running: false

		ParallelAnimation {
			NumberAnimation {
				target: foreground
				property: "scale"
				to: 0.3
				duration: 200
				easing.type: Easing.OutCubic
			}
			OpacityAnimator {
				target: foreground
				to: 0.0
				duration: 200
			}
			OpacityAnimator {
				target: background
				to: 0.0
				duration: 130
			}
		}
		PropertyAction { target: root; property: "visible"; value: false }
	}
}
