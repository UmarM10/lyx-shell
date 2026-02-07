import Quickshell.Widgets
import QtQuick

import qs

// Modal
Rectangle {
	id: root
	anchors.fill: parent
	color: "transparent"
	visible: false

	signal shown()
	signal hidden()
	function show() { showAnimation.restart(); shown() }
	function hide() { hideAnimation.restart(); hidden() }

	property int modalWidth: parent.width / 1.2
	property int modalHeight: parent.height / 1.2

	MouseArea { anchors.fill: parent; hoverEnabled: true }

	Rectangle {
		id: background
		anchors.fill: parent
		color: "black"
		opacity: 0.8
		radius: root.parent.radius

		MouseArea {
			id: backgroundMouseArea
			anchors.fill: background
			hoverEnabled: true
			onClicked: hideAnimation.restart()
		}
	}

	default property alias children: foreground.data

	Rectangle {
		id: foreground
		anchors.centerIn: parent
		color: Colors.background
		implicitHeight: root.modalHeight
		implicitWidth: root.modalWidth
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
				duration: 300
				easing.type: Easing.OutExpo
			}
			OpacityAnimator {
				target: foreground
				to: 1.0
				duration: 300
				easing.type: Easing.OutExpo
			}
			OpacityAnimator {
				target: background 
				to: 0.8
				duration: 300
				easing.type: Easing.OutExpo
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
				easing.type: Easing.InExpo
			}
			OpacityAnimator {
				target: foreground
				to: 0.0
				duration: 200
				easing.type: Easing.InExpo
			}
			OpacityAnimator {
				target: background
				to: 0.0
				duration: 130
				easing.type: Easing.InExpo
			}
		}
		PropertyAction { target: root; property: "visible"; value: false }
	}
}
