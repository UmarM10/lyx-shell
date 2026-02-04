// import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Pipewire
import QtQuick

import qs
import qs.common

ClippingRectangle {
	id: root
	visible: false
	implicitWidth: 300
	implicitHeight: 0
	opacity: 1.0
	color: Colors.background
	bottomLeftRadius: 20
	bottomRightRadius: 20
	anchors.horizontalCenter: parent.horizontalCenter
	anchors.top: parent.top
	
	function show() {}
	function hide() {}		

	SequentialAnimation {
		id: showAnimation
		running: false
		
		// PropertyAction { target: root; property: "implicitHeight"; value: 0 }
		PropertyAction { target: icon; property: "opacity"; value: 1 }
		PropertyAction { target: root; property: "visible"; value: true }
		NumberAnimation {
			target: root
			property: "implicitHeight"
			to: 65
			duration: 250
			easing.type: Easing.OutCirc
		}
	}

	SequentialAnimation {
		id: hideTimerAnimation
		running: false
		
		PauseAnimation { duration: 2000 }
		ParallelAnimation {
			NumberAnimation {
				target: root
				property: "implicitHeight"
				to: 0
				duration: 200
				easing.type: Easing.OutCirc
			}
			OpacityAnimator {
				target: icon
				to: 0.0
				duration: 200
				easing.type: Easing.OutCirc
			}
		}
		PropertyAction { target: root; property: "visible"; value: false }
	}

	LyxButton {
		id: icon
		implicitWidth: 30
		implicitHeight: 30
		anchors.verticalCenter: parent.verticalCenter
		x: 15

		MaterialIcon {
			anchors.centerIn: parent
			iconId: "volume-low-solid-full.svg"
			color: icon.foregroundColor
			width: 21
			height: 21
		}
	}

	PwObjectTracker {
		objects: Pipewire.nodes.values
	}

	Connections {
		target: Pipewire.defaultAudioSink ? Pipewire.defaultAudioSink.audio : null

		function onVolumeChanged() {
			showAnimation.restart()
			hideTimerAnimation.restart()
		}
		function onMutedChanged() {
			showAnimation.restart()
			hideTimerAnimation.restart()
		}
	}

	ClippingRectangle {
		id: track
		anchors.right: parent.right
		anchors.rightMargin: 15
		anchors.verticalCenter: parent.verticalCenter
		implicitWidth: 230
		implicitHeight: 30
		radius: 10
		color: Colors.primaryContainer

		Rectangle {
			id: leftActiveTrack
			color: Colors.primaryContainerVariant
			anchors.right: currentVolumeRect.left
			anchors.rightMargin: -5
			implicitHeight: 30
			implicitWidth: 230
		}

		Rectangle {
			id: currentVolumeRect
			radius: 10
			implicitWidth: 30
			implicitHeight: 30
			anchors.verticalCenter: parent.verticalCenter
			color: Colors.primary

			x: Pipewire.defaultAudioSink.audio.volume * 200
			Behavior on x {
				NumberAnimation {
					duration: 100
					easing.type: Easing.OutQuad
				}
			}

			LyxText {
				id: percentageText	
				anchors.centerIn: parent
				font.pointSize: 12
				font.weight: 600
				text: Math.round(Pipewire.defaultAudioSink.audio.volume * 100)
				color: Colors.background
			}
		}
	}
}
