// import Quickshell
import Quickshell.Widgets
import QtQuick 

import qs 
import qs.common 
import qs.services
import qs.modules.ControlCenter

Item {
	id: controlCenterWrapper
	anchors.bottom: parent.bottom
	anchors.bottomMargin: 10 
	anchors.left: parent.left 
	implicitWidth: root.implicitWidth 
	implicitHeight: root.implicitHeight 

	property int controlCenterWidth: 271
	property int controlCenterHeight: 375

	function show() { state = "visible" }
	function hide() { state = "invisible" }
	function toggle() { state === "visible" ? state = "invisible" : state = "visible" }

	state: "invisible"
	states: [
		State {
			name: "invisible"
			PropertyChanges {
				target: controlCenterWrapper
				// visible: false
				opacity: 0.0 
			}
			PropertyChanges {
				target: root
				// visible: false
				implicitWidth: 0 
				implicitHeight: 0 
				opacity: 0.0
			}
		},
		State {
			name: "visible" 
			PropertyChanges {
				target: controlCenterWrapper 
				visible: true 
				opacity: 1.0
			}
			PropertyChanges {
				target: root
				visible: true
				implicitWidth: controlCenterWidth
				implicitHeight: controlCenterHeight
				opacity: 1.0
			}
		}
	]
	transitions: [
		Transition {
			from: "invisible"; to: "visible"
			NumberAnimation {
				properties: "implicitWidth,implicitHeight"
				easing.type: Easing.OutExpo
				duration: 300
			}
			NumberAnimation {
				properties: "opacity"
				easing.type: Easing.OutExpo
				duration: 200
			}
		}, 
		Transition {
			from: "visible"; to: "invisible"
			SequentialAnimation {
				ParallelAnimation {
					NumberAnimation {
						properties: "implicitWidth,implicitHeight,opacity"
						easing.type: Easing.InExpo
						duration: 150
					}
				}
				PropertyAction { target: controlCenterWrapper; property: "visible"; value: false }
				PropertyAction { target: root; property: "visible"; value: false }
			}
		}
	]


	Corner {
		target: parent
		corner: "bottomLeft"
		radius: 20
		color: powerModal.visible ? "black" : Colors.background

		Behavior on color { ColorAnimation { duration: 100 } }

		anchors.bottom: target.top
		anchors.left: target.left
	}
	Corner {
		target: parent
		corner: "bottomLeft" 
		radius: 20
		color: powerModal.visible ? "black" : Colors.background

		Behavior on color { ColorAnimation { duration: 200 } }

		anchors.bottom: target.bottom
		anchors.left: target.right
	}

	ClippingRectangle {
		id: root
		implicitWidth: 300
		implicitHeight: 450
		anchors.bottom: parent.bottom
		anchors.left: parent.left
		color: Colors.background
		topRightRadius: 15
		bottomLeftRadius: 18

		Item {
			id: content
			anchors.fill: parent

			Column {
				anchors.fill: parent
				anchors.topMargin: 8
				spacing: 8
				UserSection { id: userSection; powerModal: powerModal }
				SystemTogglesSection { id: togglesSection }
				StatusBarsSection { id: statusBars }

				// LyxButton {
				// 	// Testing Wallpaper Button
				// 	implicitWidth: 100 
				// 	implicitHeight: 100 
				// 	radius: 15 
				// 	onClicked: Wallpaper.currentPath = "/home/UmarM/Pictures/abstract-paper-cut-shape-wave-background-green/simple-background-green.jpg"
				// }
			}
			PowerModal { id: powerModal; controlCenter: controlCenterWrapper }
		}
	}
}
